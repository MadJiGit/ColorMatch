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
            Section(header: Text("difficulty")) {
                Picker("Difficulty Level", selection: $settings.difficulty) {
                    ForEach(Difficulty.allCases, id: \.self) { difficulty in
                        Text(difficulty.displayName).tag(difficulty)
                    }
                }
                .pickerStyle(.segmented)

                Text(String(format: NSLocalizedString("tolerance", comment: ""), Int(settings.difficulty.tolerance)))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section(header: Text("display_options")) {
                Toggle(String(localized: "show_color_values"), isOn: $settings.showColorValues)
                    .tint(.blue)

                Text("color_values_description")
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
                        Text("target_shape")
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

                    Text("shape_selection_description")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("support")) {
                Link(destination: URL(string: "mailto:hello@mladenraykov.com")!) {
                    HStack {
                        Text("contact_us")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "envelope")
                            .foregroundColor(.blue)
                    }
                }

                Text("contact_description")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(String(localized: "settings"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
