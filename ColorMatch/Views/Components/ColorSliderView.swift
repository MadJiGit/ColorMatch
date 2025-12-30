//
//  ColorSliderView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    let color: Color
    let range: ClosedRange<Double>

    var body: some View {
        GeometryReader { geometry in
            let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)

            ZStack(alignment: .leading) {
                // Track background (inactive part)
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(height: 8)

                // Track filled part (active)
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(color)
                    .frame(width: geometry.size.width * percentage, height: 8)

                // Thumb (button)
                Capsule()
                    .foregroundColor(color)
                    .frame(width: 24, height: 40)
                    .overlay(
                        Capsule()
                            .stroke(color.opacity(0.6), lineWidth: 3)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 4)
                    .offset(x: geometry.size.width * percentage - 12)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                let newPercentage = min(max(0, gesture.location.x / geometry.size.width), 1)
                                value = range.lowerBound + newPercentage * (range.upperBound - range.lowerBound)
                            }
                    )
            }
        }
        .frame(height: 28)
    }
}

struct ColorSliderView: View {
    let label: String
    let color: Color
    @Binding var value: Double

    var body: some View {
        VStack(spacing: 0) {
            // Vertical Slider
            CustomSlider(value: $value, color: color, range: 0...255)
                .frame(width: 300, height: 60)
                .rotationEffect(.degrees(-90))
                .offset(x: -6)
                .frame(width: 60, height: 300)
                .accessibilityLabel("\(label) slider")
                .accessibilityValue("\(Int(value))")

            Spacer()
                .frame(height: 20)

            // Label at bottom
            Text(label)
                .font(.headline)
                .foregroundColor(color)
                .padding(.top, 20)
        }
    }
}

#Preview {
    @Previewable @State var redValue: Double = 128
    ColorSliderView(label: "Red", color: .red, value: $redValue)
        .padding()
}
