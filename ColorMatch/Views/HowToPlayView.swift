//
//  HowToPlayView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct HowToPlaySection: Identifiable {
    let id = UUID()
    let title: String
    let content: [String]
    var isExpanded: Bool
}

struct HowToPlayView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var settings = SettingsManager.shared
    @State private var sections: [HowToPlaySection] = [
        HowToPlaySection(
            title: "Basic Rules",
            content: [
                "1. Look at the colored circle - this is your target color",
                "2. Adjust the Red, Green, and Blue sliders",
                "3. Watch the background change as you move the sliders",
                "4. Try to match the background to the circle color",
                "5. When colors match, you win!"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "How to Play",
            content: [
                "• Move sliders up and down to change color values",
                "• Each slider controls one RGB color (0-255)",
                "• The background shows your current color mix",
                "• Match popup appears when you succeed",
                "• Tap 'Close' to try a new color"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "Understanding RGB Colors",
            content: [
                "• RGB = Red, Green, Blue",
                "• Mix these three colors to create any color",
                "• Each slider goes from 0 (none) to 255 (maximum)",
                "",
                "Color mixing examples:",
                "• Red + Green = Yellow",
                "• Red + Blue = Magenta",
                "• Green + Blue = Cyan",
                "• All three at max (255,255,255) = White",
                "• All three at min (0,0,0) = Black",
                "",
                "Pure colors:",
                "• Pure Red = (255, 0, 0)",
                "• Pure Green = (0, 255, 0)",
                "• Pure Blue = (0, 0, 255)",
                "",
                "Shades of gray:",
                "• When all three values are equal, you get gray",
                "• (128, 128, 128) = Medium gray",
                "• Higher equal values = lighter gray",
                "",
                "Fun fact: RGB is how all digital screens create colors - your phone, TV, and computer all use this system!"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "Difficulty Levels",
            content: [
                "Easy: Very forgiving, great for beginners",
                "Medium: Moderate challenge, balanced gameplay",
                "Hard: Requires precision",
                "Master: Very difficult, expert level",
                "God: Nearly impossible without seeing values!",
                "",
                "Change difficulty in Settings"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "Tips & Tricks",
            content: [
                "• Start by adjusting one color at a time",
                "• Look at the hex values (if enabled) for hints",
                "• Hide color values in Settings for more challenge",
                "• Practice with Easy mode first",
                "• Pay attention to color brightness and tone",
                "• Small adjustments work better on harder levels",
                "",
                "Environment tips:",
                "• Play in good lighting conditions",
                "• Adjust screen brightness for better color accuracy",
                "• Avoid direct sunlight on screen (creates glare)",
                "• Night mode/dark surroundings make matching harder"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "Contact Us",
            content: [
                "Have questions, feedback, or found a bug?",
                "We'd love to hear from you!",
                "",
                "Email: hello@mladenraykov.com",
                "",
                "Or just visit our website:", "https://mladenraykov.com/",
                "",
                "We respond to all messages and appreciate your input in making ColorMatch better for everyone."
            ],
            isExpanded: false
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(sections.indices, id: \.self) { index in
                        VStack(spacing: 0) {
                            // Section header
                            Button(action: {
                                withAnimation {
                                    sections[index].isExpanded.toggle()
                                }
                            }) {
                                HStack {
                                    Text(sections[index].title)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Spacer()

                                    Image(systemName: sections[index].isExpanded ? "chevron.down" : "chevron.right")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            }

                            // Section content
                            if sections[index].isExpanded {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(sections[index].content, id: \.self) { line in
                                        Text(line)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                            }
                        }

                        Divider()
                    }

                    // Show on startup toggle
                    VStack(spacing: 0) {
                        Toggle("Show this on startup", isOn: $settings.showHowToPlayOnLaunch)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("How To Play")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HowToPlayView()
}
