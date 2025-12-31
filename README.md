# Color Lab 255

An educational iOS game designed to help children learn RGB color composition through interactive gameplay.

## About

Color Lab 255 is an engaging educational app that teaches children how colors are created using RGB (Red, Green, Blue) values. Players adjust RGB sliders to match a target color, learning color theory while having fun.

## Features

- **Interactive RGB Learning**: Adjust Red, Green, and Blue sliders to create colors
- **Multiple Difficulty Levels**: Easy, Medium, Hard, Master, and God modes
- **15 Customizable Shapes**: Circle, Heart, Star, Cat, Dog, Cloud, Flame, Drop, Leaf, Sun, Moon, Snowflake, Balloon, Tortoise, and Hare
- **Multilingual Support**: Available in 6 languages - English, Bulgarian, Spanish, French, German, and Romanian
- **Educational Display**: Optional RGB value display (0-255) for each color channel
- **Dark Mode Support**: Full compatibility with iOS light and dark modes
- **COPPA Compliant**: Privacy-first design suitable for children
- **How to Play Tutorial**: Interactive accordion-style guide for new players

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ColorMatch.git
```

2. Open the project in Xcode:
```bash
cd ColorMatch
open ColorMatch.xcodeproj
```

3. Build and run on your device or simulator

## How to Play

1. Select your preferred difficulty level in Settings
2. Adjust the Red, Green, and Blue sliders to match the target color
3. The closer you get, the higher your score
4. Choose from 15 different target shapes to customize your experience

## Privacy

Color Lab 255 is designed with children's privacy in mind:
- No personal data collection
- No third-party analytics or advertising
- No in-app purchases
- COPPA compliant

See our full [Privacy Policy](PRIVACY.md) for details.

## Localization

Color Lab 255 is available in 6 languages:

- 🇬🇧 English
- 🇧🇬 Bulgarian (Български)
- 🇪🇸 Spanish (Español)
- 🇫🇷 French (Français)
- 🇩🇪 German (Deutsch)
- 🇷🇴 Romanian (Română)

The app automatically displays in your device's language. All UI elements, instructions, and tutorials are fully localized.

## Technical Architecture

- **Framework**: SwiftUI
- **Architecture**: MVVM pattern
- **Persistence**: UserDefaults for settings
- **Localization**: 6 languages with full string localization
- **Color Matching**: Euclidean distance algorithm in RGB color space
- **Custom Components**: Vertical sliders with rotation compensation

## Project Structure

```
ColorMatch/
├── Models/
│   ├── Settings.swift          # TargetShape, Difficulty, SettingsManager
│   └── GameModel.swift          # Core game logic
├── Views/
│   ├── MainMenuView.swift       # Entry point
│   ├── GameView.swift           # Main gameplay screen
│   ├── SettingsView.swift       # Settings configuration
│   ├── HowToPlayView.swift      # Tutorial accordion
│   ├── FirstLaunchPrivacyView.swift
│   ├── PrivacyPolicyView.swift
│   └── Components/
│       ├── ColorCircleView.swift
│       ├── ColorSliderView.swift
│       └── ColorDisplayView.swift
├── Localization/
│   ├── en.lproj/                # English
│   ├── bg.lproj/                # Bulgarian
│   ├── es.lproj/                # Spanish
│   ├── fr.lproj/                # French
│   ├── de.lproj/                # German
│   └── ro.lproj/                # Romanian
└── Resources/
    └── Assets.xcassets          # App icons and images
```

## Contact

- Email: [hello@mladenraykov.com](mailto:hello@mladenraykov.com)
- Website: [mladenraykov.com](https://mladenraykov.com)

## Developer

Developed by **MadJi**

## License

Copyright © 2025 Mladen Raykov. All rights reserved.
