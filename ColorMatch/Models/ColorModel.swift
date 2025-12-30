//
//  ColorModel.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct RGBColor: Equatable {
    var red: Double      // 0-255
    var green: Double    // 0-255
    var blue: Double     // 0-255

    // Computed property: Convert RGB to hex string
    var hexString: String {
        let r = Int(red)
        let g = Int(green)
        let b = Int(blue)
        return String(format: "#%02X%02X%02X", r, g, b)
    }

    // Computed property: Convert to SwiftUI Color
    var color: Color {
        Color(
            red: red / 255.0,
            green: green / 255.0,
            blue: blue / 255.0
        )
    }

    // Initialize with random RGB values
    static func random() -> RGBColor {
        RGBColor(
            red: Double.random(in: 0...255),
            green: Double.random(in: 0...255),
            blue: Double.random(in: 0...255)
        )
    }

    // Initialize with default values (black)
    init(red: Double = 0, green: Double = 0, blue: Double = 0) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
