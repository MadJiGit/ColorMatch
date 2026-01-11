//
//  MainMenuView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var settings = SettingsManager.shared
    @State private var showPrivacyPolicy = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()

                // Game Logo
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 10)

                // App Title
                Text("app_title")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Subtitle
                Text("app_subtitle")
                    .font(.title3)
                    .foregroundColor(.secondary)

                Spacer()

                // Main Buttons
                VStack(spacing: 20) {
                    // Play Game Button
                    NavigationLink(destination: GameView()) {
                        Text("play_game")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }

                    // Settings Button
                    NavigationLink(destination: SettingsView()) {
                        Text("settings")
                            .font(.title3)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                    }

                    // Privacy Policy Button
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("privacy_policy")
                            .font(.title3)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                    }
                }
                .frame(maxWidth: 500) // Limit button width on iPad
                .padding(.horizontal, 40)

                Spacer()

                // Logo and Developer Credit (bottom)
                Link(destination: URL(string: "https://mladenraykov.com")!) {
                    VStack(spacing: 8) {
                        // Adaptive logo for light/dark mode
                        Image(colorScheme == .dark ? "MadJiLogoGreyScaleInverted" : "MadJiLogoGreyScale")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
//                            )

                        Text("developed_by")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
            .fullScreenCover(isPresented: $showPrivacyPolicy) {
                FirstLaunchPrivacyView()
            }
            .onAppear {
                if !settings.hasAcceptedPrivacyPolicy {
                    showPrivacyPolicy = true
                }
            }
        }
    }
}

#Preview {
    MainMenuView()
}
