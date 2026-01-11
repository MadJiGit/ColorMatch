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
        case .circle: return String(localized: "shape_circle")
        case .heart: return String(localized: "shape_heart")
        case .star: return String(localized: "shape_star")
        case .cat: return String(localized: "shape_cat")
        case .dog: return String(localized: "shape_dog")
        case .cloud: return String(localized: "shape_cloud")
        case .flame: return String(localized: "shape_flame")
        case .drop: return String(localized: "shape_drop")
        case .leaf: return String(localized: "shape_leaf")
        case .sun: return String(localized: "shape_sun")
        case .moon: return String(localized: "shape_moon")
        case .snowflake: return String(localized: "shape_snowflake")
        case .balloon: return String(localized: "shape_balloon")
        case .tortoise: return String(localized: "shape_tortoise")
        case .hare: return String(localized: "shape_hare")
        }
    }
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case master = "Master"
    case god = "God"

    var displayName: String {
        switch self {
        case .easy: return String(localized: "difficulty_easy")
        case .medium: return String(localized: "difficulty_medium")
        case .hard: return String(localized: "difficulty_hard")
        case .master: return String(localized: "difficulty_master")
        case .god: return String(localized: "difficulty_god")
        }
    }

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

    @Published var competitionMode: Bool {
        didSet {
            UserDefaults.standard.set(competitionMode, forKey: "competitionMode")
            // Auto-disable Show Color Values when Competition Mode is ON
            if competitionMode {
                showColorValues = false
            }
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

        // Load competition mode (default false) - MUST be loaded before showColorValues
        self.competitionMode = UserDefaults.standard.object(forKey: "competitionMode") as? Bool ?? false

        // Load show color values (default true, but disabled if competition mode is on)
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
