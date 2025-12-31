//
//  FirstLaunchPrivacyView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct FirstLaunchPrivacyView: View {
    @ObservedObject var settings = SettingsManager.shared
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 16) {
                    Text("welcome_title")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text("welcome_subtitle")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)

                // Privacy Policy Content
                VStack(alignment: .leading, spacing: 20) {
                    // Key Points
                    VStack(alignment: .leading, spacing: 16) {
                        Text("your_privacy_matters")
                            .font(.title2)
                            .fontWeight(.semibold)

                        privacyPoint(icon: "lock.shield.fill", text: String(localized: "privacy_point_1"))
                        privacyPoint(icon: "wifi.slash", text: String(localized: "privacy_point_2"))
                        privacyPoint(icon: "person.crop.circle.badge.xmark", text: String(localized: "privacy_point_3"))
                        privacyPoint(icon: "dollarsign.circle.fill", text: String(localized: "privacy_point_4"))
                        privacyPoint(icon: "hand.raised.fill", text: String(localized: "privacy_point_5"))
                    }

                    Divider()

                    // What we store locally
                    VStack(alignment: .leading, spacing: 12) {
                        Text("whats_stored_title")
                            .font(.headline)

                        Text("whats_stored_subtitle")
                            .font(.body)
                            .foregroundColor(.secondary)

                        VStack(alignment: .leading, spacing: 8) {
                            localStorageItem(String(localized: "stored_item_difficulty"))
                            localStorageItem(String(localized: "stored_item_display"))
                            localStorageItem(String(localized: "stored_item_tutorial"))
                        }

                        Text("stored_note")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .italic()
                    }

                    Divider()

                    // Full Policy Link
                    VStack(alignment: .leading, spacing: 8) {
                        Text("full_policy_text")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)

                // Continue Button
                VStack(spacing: 12) {
                    Button(action: {
                        settings.hasAcceptedPrivacyPolicy = true
                        dismiss()
                    }) {
                        Text("continue_button")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 30)

                    Text("agree_text")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 30)
                .padding(.bottom, 40)
            }
        }
        .background(Color(.systemBackground))
    }

    private func privacyPoint(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.green)
                .frame(width: 24)

            Text(text)
                .font(.body)
        }
    }

    private func localStorageItem(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.body)
            Text(text)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.leading, 8)
    }
}

#Preview {
    FirstLaunchPrivacyView()
}
