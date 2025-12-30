//
//  Settings.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import Foundation

enum TargetShape: String, CaseIterable {
    case circle = "circle.fill"
    case heart = "heart.fill"
    case star = "star.fill"
    case cat = "cat.fill"
    case dog = "dog.fill"
    case cloud = "cloud.fill"
    case flame = "flame.fill"
    case drop = "drop.fill"
    case leaf = "leaf.fill"
    case sun = "sun.max.fill"
    case moon = "moon.fill"
    case snowflake = "snowflake"
    case balloon = "balloon.fill"
    case tortoise = "tortoise.fill"
    case hare = "hare.fill"

    var displayName: String {
        switch self {
        case .circle: return "Circle"
        case .heart: return "Heart"
        case .star: return "Star"
        case .cat: return "Cat"
        case .dog: return "Dog"
        case .cloud: return "Cloud"
        case .flame: return "Flame"
        case .drop: return "Drop"
        case .leaf: return "Leaf"
        case .sun: return "Sun"
        case .moon: return "Moon"
        case .snowflake: return "Snowflake"
        case .balloon: return "Balloon"
        case .tortoise: return "Tortoise"
        case .hare: return "Hare"
        }
    }
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case master = "Master"
    case god = "God"

    var tolerance: Double {
        switch self {
        case .easy: return 30.0
        case .medium: return 20.0
        case .hard: return 15.0
        case .master: return 10.0
        case .god: return 5.0
        }
    }
}

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()

    @Published var difficulty: Difficulty {
        didSet {
            UserDefaults.standard.set(difficulty.rawValue, forKey: "difficulty")
        }
    }

    @Published var showColorValues: Bool {
        didSet {
            UserDefaults.standard.set(showColorValues, forKey: "showColorValues")
        }
    }

    @Published var showHowToPlayOnLaunch: Bool {
        didSet {
            UserDefaults.standard.set(showHowToPlayOnLaunch, forKey: "showHowToPlayOnLaunch")
        }
    }

    @Published var hasAcceptedPrivacyPolicy: Bool {
        didSet {
            UserDefaults.standard.set(hasAcceptedPrivacyPolicy, forKey: "hasAcceptedPrivacyPolicy")
        }
    }

    @Published var targetShape: TargetShape {
        didSet {
            UserDefaults.standard.set(targetShape.rawValue, forKey: "targetShape")
        }
    }

    private init() {
        // Load difficulty
        if let savedDifficulty = UserDefaults.standard.string(forKey: "difficulty"),
           let difficulty = Difficulty(rawValue: savedDifficulty) {
            self.difficulty = difficulty
        } else {
            self.difficulty = .medium // Default
        }

        // Load show color values (default true)
        self.showColorValues = UserDefaults.standard.object(forKey: "showColorValues") as? Bool ?? true

        // Load show how to play on launch (default true for first time)
        self.showHowToPlayOnLaunch = UserDefaults.standard.object(forKey: "showHowToPlayOnLaunch") as? Bool ?? true

        // Load privacy policy acceptance (default false - must see on first launch)
        self.hasAcceptedPrivacyPolicy = UserDefaults.standard.object(forKey: "hasAcceptedPrivacyPolicy") as? Bool ?? false

        // Load target shape (default circle)
        if let savedShape = UserDefaults.standard.string(forKey: "targetShape"),
           let shape = TargetShape(rawValue: savedShape) {
            self.targetShape = shape
        } else {
            self.targetShape = .circle
        }
    }
}
