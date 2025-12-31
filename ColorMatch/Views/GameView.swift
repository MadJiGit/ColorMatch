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

    var body: some View {
        ZStack {
            // Adaptive background
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 8) {
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

                VStack(spacing: 20) {
                    Text("match")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)

                    Button(action: {
                        showMatchPopup = false
                    }) {
                        Text("close")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(40)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 20)
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
        viewModel.updateCurrentColor(
            red: redValue,
            green: greenValue,
            blue: blueValue
        )
    }

    private func newGame() {
        viewModel.generateNewColor()
        // Reset sliders to 0
        redValue = 0
        greenValue = 0
        blueValue = 0
    }

    // Determine text color based on background brightness
    private var contrastTextColor: Color {
        let brightness = (viewModel.currentColor.red * 299 +
                         viewModel.currentColor.green * 587 +
                         viewModel.currentColor.blue * 114) / 1000
        return brightness > 127 ? .black : .white
    }
}

#Preview {
    NavigationStack {
        GameView()
    }
}
