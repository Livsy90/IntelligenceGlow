# IntelligenceGlow

A lightweight SwiftUI library that brings an **Apple Intelligence–style glowing stroke effect** to any `InsettableShape`.  
It uses animated angular gradients, layered blurs, and smooth transitions to recreate the dynamic glow seen in Apple’s design language.

https://github.com/user-attachments/assets/d6e1ee27-c220-4d50-a24a-42b1b6a491f8

## Features

- ✨ Apply a glowing gradient as **background** or **overlay**  
- 🎨 Fully customizable line widths, blur radii, and animation durations  
- 🌈 Gradient stops automatically regenerate for a flowing effect  
- ♿ Respects **Reduce Motion** accessibility settings  
- 🧩 Works with any built-in `InsettableShape` (`Circle`, `Capsule`, `RoundedRectangle`, etc.)

## Installation

### Swift Package Manager

In Xcode:  
`File > Add Packages > https://github.com/Livsy90/IntelligenceGlow.git`

## Usage

### Basic Example

```swift
import SwiftUI
import IntelligenceGlow

struct ContentView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Glowing Capsule")
                .padding(22)
                .intelligenceBackground(in: Capsule())

            Text("Glowing Rectangle")
                .padding(22)
                .intelligenceOverlay(in: .rect(cornerRadius: 22))
        }
    }
}
```

### Sweep Highlight

Use `intelligenceSweep` when you want a moving Apple Intelligence-style sweep around a shape border instead of the full multi-layer glow:

```swift
Text("Intelligence Sweep")
    .font(.headline)
    .padding(22)
    .intelligenceSweep(
        in: .capsule,
    )
```

### Customizing the Glow

You can control line widths, blurs, animation speed, and gradient generation:

```swift
Text("Intelligence Glow")
    .padding(24)
    .intelligenceOverlay(
        in: Capsule(),
        lineWidths: [4, 8, 12],
        blurs: [0, 6, 12],
        updateInterval: 0.5,
        animationDurations: [0.6, 0.8, 1.2],
        gradientGenerator: .intelligenceStyle
    )
```

## API

### View Extensions

```swift
func intelligenceBackground<S: InsettableShape>(in shape: S, ...)
func intelligenceOverlay<S: InsettableShape>(in shape: S, ...)
@available(iOS 17.0, *)
func intelligenceSweep<S: InsettableShape>(
    in shape: S,
    borderColor: Color = .primary,
    colors: [Color] = .intelligenceColors,
    blurRadius: CGFloat = 18,
    lineWidth: CGFloat = 0.7,
    sweepSpan: Double = 130,
    sweepOffset: Double = 140
) -> some View
```

### Shape Extension

```swift
func intelligenceStroke(
    lineWidths: [CGFloat] = [6, 9, 11, 15],
    blurs: [CGFloat] = [0, 4, 12, 15],
    updateInterval: TimeInterval = 0.4,
    animationDurations: [TimeInterval] = [0.5, 0.6, 0.8, 1.0],
    gradientGenerator: @escaping () -> [Gradient.Stop] = { .intelligenceStyle }
) -> some View
```

## Preview

```swift
#Preview {
    VStack(spacing: 45) {
        if #available(iOS 17.0, *) {
            Text("Intelligence Sweep")
                .font(.headline)
                .padding(22)
                .intelligenceSweep(
                    in: .capsule,
                    borderColor: .purple,
                    sweepSpan: 130,
                    sweepOffset: 140
                )
            
            Text("Intelligence Glow Overlay")
                .font(.headline)
                .padding(22)
                .intelligenceOverlay(in: .rect(cornerRadius: 22))
            
            Text("Intelligence Glow Background")
                .font(.headline)
                .padding(22)
                .intelligenceBackground(in: .capsule)
            
            if #available(iOS 26.0, *) {
                Text("Intelligence Glow Glass Background")
                    .font(.headline)
                    .padding(22)
                    .glassEffect()
                    .intelligenceBackground(in: .capsule)
                
                Text("Intelligence Glass Sweep")
                    .font(.headline)
                    .padding(22)
                    .glassEffect(.clear)
                    .intelligenceSweep(
                        in: .capsule,
                        blurRadius: 45,
                        sweepSpan: 90,
                        sweepOffset: 220
                    )
                
                Text("Intelligence Sweep + Intelligence Glow")
                    .font(.headline)
                    .padding(22)
                    .glassEffect(.clear)
                    .intelligenceBackground(in: .capsule)
                    .intelligenceSweep(
                        in: .capsule,
                        blurRadius: 45,
                        sweepSpan: 90,
                        sweepOffset: 220
                    )
            }
        }
    }
}
```
