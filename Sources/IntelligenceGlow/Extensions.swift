import SwiftUI

public extension Array where Element == Gradient.Stop {
    static var intelligenceStyle: [Gradient.Stop] {
        [Color]
            .intelligenceColors
            .map {
                Gradient.Stop(color: $0, location: Double.random(in: 0...1))
            }
            .sorted {
                $0.location < $1.location
            }
    }
}

public extension Array where Element == Color {
    static var intelligenceColors: [Color] {
        [
            Color(red: 188/255, green: 130/255, blue: 243/255),
            Color(red: 245/255, green: 185/255, blue: 234/255),
            Color(red: 141/255, green: 159/255, blue: 255/255),
            Color(red: 255/255, green: 103/255, blue: 120/255),
            Color(red: 255/255, green: 186/255, blue: 113/255),
            Color(red: 198/255, green: 134/255, blue: 255/255)
        ]
    }
}
