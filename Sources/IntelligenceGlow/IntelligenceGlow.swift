import SwiftUI

public extension View {
    /// Applies a glowing angular-gradient stroke as a background using the provided shape.
    @MainActor
    func intelligenceBackground<S: InsettableShape>(
        in shape: S,
        lineWidths: [CGFloat] = [6, 9, 11, 15],
        blurs: [CGFloat] = [0, 4, 12, 15],
        updateInterval: TimeInterval = 0.4,
        animationDurations: [TimeInterval] = [0.5, 0.6, 0.8, 1.0],
        gradientGenerator: @MainActor @Sendable @escaping @autoclosure () -> [Gradient.Stop] = .intelligenceStyle
    ) -> some View {
        background(
            shape.intelligenceStroke(
                lineWidths: lineWidths,
                blurs: blurs,
                updateInterval: updateInterval,
                animationDurations: animationDurations,
                gradientGenerator: gradientGenerator
            )
        )
    }
    
    /// Applies a glowing angular-gradient stroke as an overlay using the provided shape.
    @MainActor
    func intelligenceOverlay<S: InsettableShape>(
        in shape: S,
        lineWidths: [CGFloat] = [6, 9, 11, 15],
        blurs: [CGFloat] = [0, 4, 12, 15],
        updateInterval: TimeInterval = 0.4,
        animationDurations: [TimeInterval] = [0.5, 0.6, 0.8, 1.0],
        gradientGenerator: @MainActor @Sendable @escaping @autoclosure () -> [Gradient.Stop] = .intelligenceStyle
    ) -> some View {
        overlay(
            shape.intelligenceStroke(
                lineWidths: lineWidths,
                blurs: blurs,
                updateInterval: updateInterval,
                animationDurations: animationDurations,
                gradientGenerator: gradientGenerator
            )
        )
    }
}

public extension InsettableShape {
    /// Applies an Apple Intelligence–style animated angular-gradient glow stroke to any Shape.
    /// - Parameters:
    ///   - lineWidths: Line widths for each glow layer.
    ///   - blurs: Blur radius for each corresponding glow layer.
    ///   - updateInterval: How often to regenerate gradient stops.
    ///   - animationDurations: Animation duration per layer when gradient changes.
    ///   - gradientGenerator: Function that returns a new set of `Gradient.Stop` values.
    /// - Returns: A view that renders the shape with a glowing gradient stroke.
    @MainActor
    func intelligenceStroke(
        lineWidths: [CGFloat] = [6, 9, 11, 15],
        blurs: [CGFloat] = [0, 4, 12, 15],
        updateInterval: TimeInterval = 0.4,
        animationDurations: [TimeInterval] = [0.5, 0.6, 0.8, 1.0],
        gradientGenerator: @MainActor @Sendable @escaping () -> [Gradient.Stop] = { .intelligenceStyle }
    ) -> some View {
        IntelligenceStrokeView(
            shape: self,
            lineWidths: lineWidths,
            blurs: blurs,
            updateInterval: updateInterval,
            animationDurations: animationDurations,
            gradientGenerator: gradientGenerator
        )
        .allowsHitTesting(false)
    }
}

// MARK: - Generic glow stroke for any Shape

private struct IntelligenceStrokeView<S: InsettableShape>: View {
    let shape: S
    let lineWidths: [CGFloat]
    let blurs: [CGFloat]
    let updateInterval: TimeInterval
    let animationDurations: [TimeInterval]
    let gradientGenerator: @MainActor @Sendable () -> [Gradient.Stop]

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var stops: [Gradient.Stop] = .intelligenceStyle

    var body: some View {
        let layerCount = min(lineWidths.count, blurs.count, animationDurations.count)
        let gradient = AngularGradient(
            gradient: Gradient(stops: stops),
            center: .center
        )

        ZStack {
            ForEach(0..<layerCount, id: \.self) { i in
                shape
                    .strokeBorder(gradient, lineWidth: lineWidths[i])
                    .blur(radius: blurs[i])
                    .animation(
                        reduceMotion ? .linear(duration: 0) : .easeInOut(duration: animationDurations[i]),
                        value: stops
                    )
            }
        }
        .task(id: updateInterval) {
            while !Task.isCancelled {
                stops = gradientGenerator()
                if #available(iOS 16.0, *) {
                    try? await Task.sleep(for: .seconds(updateInterval))
                } else {
                    try? await Task.sleep(nanoseconds: UInt64(updateInterval * 1_000_000_000))
                }
            }
        }
    }
}
