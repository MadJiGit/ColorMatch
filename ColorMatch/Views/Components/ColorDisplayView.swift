//
//  ColorDisplayView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct ColorDisplayView: View {
    let label: String
    let color: Color
    let hexCode: String

    var body: some View {
        VStack(spacing: 4) {
            // Label
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)

            // Hex code
            Text(hexCode)
                .font(.system(.callout, design: .monospaced))
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    ColorDisplayView(label: "Target Color", color: .red, hexCode: "#FF0000")
}
