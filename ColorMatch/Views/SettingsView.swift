//
//  SettingsView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings = SettingsManager.shared
    @State private var isTargetShapeExpanded = false

    var body: some View {
        Form {
            Section(header: Text("Difficulty")) {
                Picker("Difficulty Level", selection: $settings.difficulty) {
                    ForEach(Difficulty.allCases, id: \.self) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(.segmented)

                Text("Tolerance: \(Int(settings.difficulty.tolerance))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section(header: Text("Display Options")) {
                Toggle("Show Color Values", isOn: $settings.showColorValues)
                    .tint(.blue)

                Text("Toggle to show/hide hex color codes during gameplay")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section {
                // Header button
                Button(action: {
                    withAnimation {
                        isTargetShapeExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text("Target Shape")
                            .font(.headline)
                            .foregroundColor(.primary)

                        Spacer()

                        Image(systemName: isTargetShapeExpanded ? "chevron.down" : "chevron.right")
                            .foregroundColor(.blue)
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                .buttonStyle(PlainButtonStyle())

                // Expandable content
                if isTargetShapeExpanded {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(TargetShape.allCases, id: \.self) { shape in
                            VStack(spacing: 8) {
                                Image(systemName: shape.rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(settings.targetShape == shape ? .blue : .secondary)
                                    .padding(12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(settings.targetShape == shape ? Color.blue.opacity(0.1) : Color.clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(settings.targetShape == shape ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                                    )

                                Text(shape.displayName)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .onTapGesture {
                                settings.targetShape = shape
                            }
                        }
                    }
                    .padding(.vertical, 8)

                    Text("Select the shape for the target color")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("Support")) {
                Link(destination: URL(string: "mailto:hello@mladenraykov.com")!) {
                    HStack {
                        Text("Contact Us")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "envelope")
                            .foregroundColor(.blue)
                    }
                }

                Text("Send us feedback or report issues at hello@mladenraykov.com")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
