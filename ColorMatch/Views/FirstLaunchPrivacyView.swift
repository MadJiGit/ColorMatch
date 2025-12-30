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
                    Text("Welcome to\nColor Lab 255!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text("Before you start, please review our Privacy Policy")
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
                        Text("Your Privacy Matters")
                            .font(.title2)
                            .fontWeight(.semibold)

                        privacyPoint(icon: "lock.shield.fill", text: "We do NOT collect any personal data")
                        privacyPoint(icon: "wifi.slash", text: "No internet required - completely offline")
                        privacyPoint(icon: "person.crop.circle.badge.xmark", text: "No account or registration needed")
                        privacyPoint(icon: "dollarsign.circle.fill", text: "No advertisements")
                        privacyPoint(icon: "hand.raised.fill", text: "COPPA compliant - safe for children")
                    }

                    Divider()

                    // What we store locally
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What's Stored on Your Device")
                            .font(.headline)

                        Text("Only your game preferences are saved locally:")
                            .font(.body)
                            .foregroundColor(.secondary)

                        VStack(alignment: .leading, spacing: 8) {
                            localStorageItem("Difficulty level")
                            localStorageItem("Color values display preference")
                            localStorageItem("Tutorial settings")
                        }

                        Text("This data never leaves your device.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .italic()
                    }

                    Divider()

                    // Full Policy Link
                    VStack(alignment: .leading, spacing: 8) {
                        Text("For complete details, you can read our full Privacy Policy anytime from the main menu.")
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
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 30)

                    Text("By continuing, you agree to our Privacy Policy")
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
