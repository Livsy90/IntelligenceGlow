# IntelligenceGlow

<img src="https://github.com/Livsy90/IntelligenceGlow/blob/main/demo.gif">

A lightweight SwiftUI library that brings an **Apple Intelligence–style glowing stroke effect** to any `InsettableShape`.  
It uses animated angular gradients, layered blurs, and smooth transitions to recreate the dynamic glow seen in Apple’s design language.

## Features

- ✨ Apply a glowing gradient as **background** or **overlay**  
- 🎨 Fully customizable line widths, blur radii, and animation durations  
- 🌈 Gradient stops automatically regenerate for a flowing effect  
- ♿ Respects **Reduce Motion** accessibility settings  
- 🧩 Works with any built-in `InsettableShape` (`Circle`, `Capsule`, `RoundedRectangle`, etc.)

## Installation

### Swift Package Manager

In Xcode:  
`File > Add Packages > https://github.com/your-username/IntelligenceGlow.git`

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
                .intelligenceOverlay(in: RoundedRectangle(cornerRadius: 22))
        }
    }
}
```

### Customizing the Glow

You can control line widths, blurs, animation speed, and gradient generation:

```swift
Text("Custom Glow")
    .padding(24)
    .intelligenceOverlay(
        in: Capsule(),
        lineWidths: [4, 8, 12],
        blurs: [0, 6, 12],
        updateInterval: 0.5,
        animationDurations: [0.6, 0.8, 1.2],
        gradientGenerator: { .intelligenceStyle }
    )
```

## API

### View Extensions

```swift
func intelligenceBackground<S: InsettableShape>(in shape: S, ...)
func intelligenceOverlay<S: InsettableShape>(in shape: S, ...)
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
    VStack(spacing: 30) {
        Text("Some text here")
            .padding(22)
            .intelligenceBackground(in: .capsule)

        Text("Some text here")
            .padding(22)
            .intelligenceOverlay(in: .rect(cornerRadius: 22))
    }
}
```
