//
//  GameViewModel.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var targetColor: RGBColor
    @Published var currentColor: RGBColor
    @Published var gameState: GameState

    // MARK: - Settings
    private let settings = SettingsManager.shared

    // MARK: - Initialization
    init() {
        self.targetColor = RGBColor.random()
        self.currentColor = RGBColor(red: 0, green: 0, blue: 0)
        self.gameState = .playing
    }

    // MARK: - Public Methods

    /// Generate a new random target color and reset the game
    func generateNewColor() {
        targetColor = RGBColor.random()
        currentColor = RGBColor(red: 0, green: 0, blue: 0)
        gameState = .playing
    }

    /// Update current color from slider values
    func updateCurrentColor(red: Double, green: Double, blue: Double) {
        currentColor = RGBColor(red: red, green: green, blue: blue)
        checkColorMatch()
    }

    /// Reset the game with a new target color
    func resetGame() {
        generateNewColor()
    }

    // MARK: - Private Methods

    /// Check if current color matches target color within tolerance
    private func checkColorMatch() {
        let distance = colorDistance(color1: targetColor, color2: currentColor)

        if distance <= settings.difficulty.tolerance {
            gameState = .matched
        } else {
            gameState = .playing
        }
    }

    /// Calculate Euclidean distance between two RGB colors
    /// Formula: √[(R₁-R₂)² + (G₁-G₂)² + (B₁-B₂)²]
    private func colorDistance(color1: RGBColor, color2: RGBColor) -> Double {
        let rDiff = color1.red - color2.red
        let gDiff = color1.green - color2.green
        let bDiff = color1.blue - color2.blue

        return sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
    }
}
