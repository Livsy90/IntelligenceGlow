import SwiftUI

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
