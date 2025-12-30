//
//  ColorCircleView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct ColorCircleView: View {
    let color: Color
    let size: CGFloat
    @ObservedObject var settings = SettingsManager.shared

    var body: some View {
        if settings.targetShape == .circle {
            // Circle shape (special case - uses Circle() not Image)
            Circle()
                .fill(color)
                .frame(width: size, height: size)
                .shadow(color: .black.opacity(0.0), radius: 10, x: 0, y: 0)
        } else {
            // All other shapes (SF Symbols)
            Image(systemName: settings.targetShape.rawValue)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: size, height: size)
                .shadow(color: .black.opacity(0.0), radius: 10, x: 0, y: 0)
        }
    }
}

#Preview {
    ColorCircleView(color: .red, size: 100)
}
