//
//  GameView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @ObservedObject var settings = SettingsManager.shared
    @State private var redValue: Double = 0
    @State private var greenValue: Double = 0
    @State private var blueValue: Double = 0
    @State private var showMatchPopup = false
    @State private var showHowToPlay = false

    // Timer for Competition Mode
    @State private var timerValue: Double = 0.0
    @State private var timer: Timer?
    @State private var hasStartedPlaying = false
    @State private var finalTime: String = ""
    @State private var isResetting = false

    var body: some View {
        ZStack {
            // Adaptive background
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 8) {
                // Timer display (only in Competition Mode)
                if settings.competitionMode {
                    Text(formatTime(timerValue))
                        .font(.system(size: 36, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                }

                // Rectangle with changing background color and circle
                ZStack {
                    // Background rectangle that changes with slider values
                    viewModel.currentColor.color

                    // Target Color Circle on top
                    ColorCircleView(
                        color: viewModel.targetColor.color,
                        size: 80
                    )
                }
                .frame(width: 300, height: 220)
                .cornerRadius(16)
                .padding(.top, 20)

                // Color Displays (conditionally shown)
                if settings.showColorValues {
                    HStack(spacing: 30) {
                        ColorDisplayView(
                            label: String(localized: "target"),
                            color: viewModel.targetColor.color,
                            hexCode: viewModel.targetColor.hexString
                        )

                        ColorDisplayView(
                            label: String(localized: "current"),
                            color: viewModel.currentColor.color,
                            hexCode: viewModel.currentColor.hexString
                        )
                    }
                    .padding(.vertical, 20)
                }
                else {
                    HStack(spacing: 30){
                        
                    }
                        .padding(.vertical, 20)
                }

                // RGB Sliders
                HStack(spacing: 30) {
                    VStack(alignment: .center, spacing: 16) {
                        if settings.showColorValues {
                            Text("\(Int(redValue))")
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(width: 60, alignment: .center)
                        }
                        ColorSliderView(
                            label: String(localized: "red"),
                            color: .red,
                            value: $redValue
                        )
                        .onChange(of: redValue) { _, newValue in
                            updateColor()
                        }
                    }
                    .frame(width: 60)

                    VStack(alignment: .center, spacing: 16) {
                        if settings.showColorValues {
                            Text("\(Int(greenValue))")
                                .font(.headline)
                                .foregroundColor(.green)
                                .frame(width: 60, alignment: .center)
                        }
                        ColorSliderView(
                            label: String(localized: "green"),
                            color: .green,
                            value: $greenValue
                        )
                        .onChange(of: greenValue) { _, newValue in
                            updateColor()
                        }
                    }
                    .frame(width: 60)

                    VStack(alignment: .center, spacing: 16) {
                        if settings.showColorValues {
                            Text("\(Int(blueValue))")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 60, alignment: .center)
                        }
                        ColorSliderView(
                            label: String(localized: "blue"),
                            color: .blue,
                            value: $blueValue
                        )
                        .onChange(of: blueValue) { _, newValue in
                            updateColor()
                        }
                    }
                    .frame(width: 60)
                }
                .padding(.horizontal, 20)

                Spacer()
            }

            // Match Popup Overlay
            if showMatchPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showMatchPopup = false
                    }

                VStack(spacing: settings.competitionMode ? 16 : 20) {
                    // Match title
                    Text("match")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)

                    // Competition Mode: Show time and level
                    if settings.competitionMode {
                        VStack(spacing: 8) {
                            HStack {
                                Text("time_elapsed")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(finalTime)
                                    .font(.system(.title3, design: .monospaced))
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 12)

                            HStack {
                                Text("your_level")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(settings.difficulty.displayName)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 12)
                        }
                        .padding(.vertical, 8)
                    }

                    // Buttons
                    VStack(spacing: 10) {
                        // New Game button (always visible)
                        Button(action: {
                            showMatchPopup = false
                            newGame()
                            // Don't reset hasStartedPlaying here - let it reset on first slider movement
                        }) {
                            Text("new_game")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }

                        // Close button - just dismisses popup, doesn't start new game
                        Button(action: {
                            showMatchPopup = false
                            // User can view the matched result or use back button to return to menu
                        }) {
                            Text("close")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }

                    // Share section at the bottom (always visible)
                    Divider()
                        .padding(.vertical, 4)

                    // Share prompt
                    Text(settings.competitionMode ? "share_prompt" : "share_prompt_normal")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)

                    // Share Result button
                    Button(action: {
                        shareResult()
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 14))
                            Text("share_result")
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                .frame(maxWidth: 400) // Limit width on iPad
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding(.horizontal, 40)
            }
        }
        .navigationTitle(String(localized: "game_title"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showHowToPlay = true
                }) {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 20))
                }
            }
        }
        .sheet(isPresented: $showHowToPlay) {
            HowToPlayView()
        }
        .onChange(of: viewModel.gameState) { _, newState in
            if newState == .matched {
                if settings.competitionMode {
                    stopTimer()
                }
                showMatchPopup = true
            }
        }
        .onAppear {
            if settings.showHowToPlayOnLaunch {
                // Small delay to ensure any other modals are dismissed first
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showHowToPlay = true
                }
            }
        }
    }

    // MARK: - Helper Methods

    private func updateColor() {
        // Start timer on first slider movement in Competition Mode (but not during reset)
        if settings.competitionMode && !hasStartedPlaying && !isResetting {
            startTimer()
            hasStartedPlaying = true
        }

        viewModel.updateCurrentColor(
            red: redValue,
            green: greenValue,
            blue: blueValue
        )
    }

    private func resetGameState() {
        hasStartedPlaying = false
        timerValue = 0.0
        timer?.invalidate()
        timer = nil
    }

    private func newGame() {
        isResetting = true
        viewModel.generateNewColor()
        resetGameState()
        // Reset sliders to 0
        redValue = 0
        greenValue = 0
        blueValue = 0
        // Wait for all onChange callbacks to finish before allowing timer to start
        DispatchQueue.main.async {
            self.isResetting = false
        }
    }

    private func shareResult() {
        let shareText: String

        if settings.competitionMode {
            // Competition Mode: Share time and level
            shareText = String(
                format: NSLocalizedString("share_text", comment: ""),
                finalTime,
                settings.difficulty.displayName
            )
        } else {
            // Normal Mode: Share promotional text
            shareText = NSLocalizedString("share_text_normal", comment: "")
        }

        // App Store link - iOS will automatically show app preview with icon
        let appStoreURL = URL(string: "https://apps.apple.com/bg/app/color-lab-255/id6757189833")!

        let activityVC = UIActivityViewController(
            activityItems: [shareText, appStoreURL],
            applicationActivities: nil
        )

        // Get the current window scene
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            // Present from root view controller
            var presentingVC = rootVC
            while let presented = presentingVC.presentedViewController {
                presentingVC = presented
            }
            activityVC.popoverPresentationController?.sourceView = presentingVC.view
            activityVC.popoverPresentationController?.sourceRect = CGRect(
                x: presentingVC.view.bounds.midX,
                y: presentingVC.view.bounds.midY,
                width: 0,
                height: 0
            )
            presentingVC.present(activityVC, animated: true)
        }
    }

    // Determine text color based on background brightness
    private var contrastTextColor: Color {
        let brightness = (viewModel.currentColor.red * 299 +
                         viewModel.currentColor.green * 587 +
                         viewModel.currentColor.blue * 114) / 1000
        return brightness > 127 ? .black : .white
    }

    // MARK: - Timer Methods

    private func startTimer() {
        timerValue = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            timerValue += 0.01
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        finalTime = formatTime(timerValue)
    }

    private func formatTime(_ time: Double) -> String {
        let seconds = Int(time)
        let hundredths = Int((time - Double(seconds)) * 100)
        return String(format: "%d.%02ds", seconds, hundredths)
    }
}

#Preview {
    NavigationStack {
        GameView()
    }
}
