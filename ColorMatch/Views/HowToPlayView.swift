//
//  HowToPlayView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct HowToPlaySection: Identifiable {
    let id = UUID()
    let title: String
    let content: [String]
    var isExpanded: Bool
}

struct HowToPlayView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var settings = SettingsManager.shared
    @State private var sections: [HowToPlaySection] = [
        HowToPlaySection(
            title: "section_basic_rules",
            content: [
                "basic_rule_1",
                "basic_rule_2",
                "basic_rule_3",
                "basic_rule_4",
                "basic_rule_5"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "section_how_to_play",
            content: [
                "how_to_play_1",
                "how_to_play_2",
                "how_to_play_3",
                "how_to_play_4",
                "how_to_play_5"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "section_understanding_rgb",
            content: [
                "rgb_intro_1",
                "rgb_intro_2",
                "rgb_intro_3",
                "",
                "rgb_mixing_header",
                "rgb_mixing_1",
                "rgb_mixing_2",
                "rgb_mixing_3",
                "rgb_mixing_4",
                "rgb_mixing_5",
                "",
                "rgb_pure_header",
                "rgb_pure_1",
                "rgb_pure_2",
                "rgb_pure_3",
                "",
                "rgb_gray_header",
                "rgb_gray_1",
                "rgb_gray_2",
                "rgb_gray_3",
                "",
                "rgb_fun_fact"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "section_difficulty_levels",
            content: [
                "difficulty_easy_desc",
                "difficulty_medium_desc",
                "difficulty_hard_desc",
                "difficulty_master_desc",
                "difficulty_god_desc",
                "",
                "change_difficulty"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "section_tips",
            content: [
                "tip_1",
                "tip_2",
                "tip_3",
                "tip_4",
                "tip_5",
                "tip_6",
                "",
                "environment_tips_header",
                "env_tip_1",
                "env_tip_2",
                "env_tip_3",
                "env_tip_4"
            ],
            isExpanded: false
        ),
        HowToPlaySection(
            title: "section_contact",
            content: [
                "contact_question",
                "contact_love_to_hear",
                "",
                "contact_email",
                "",
                "contact_website",
                "contact_website_url",
                "",
                "contact_response"
            ],
            isExpanded: false
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(sections.indices, id: \.self) { index in
                        VStack(spacing: 0) {
                            // Section header
                            Button(action: {
                                withAnimation {
                                    sections[index].isExpanded.toggle()
                                }
                            }) {
                                HStack {
                                    Text(LocalizedStringKey(sections[index].title))
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Spacer()

                                    Image(systemName: sections[index].isExpanded ? "chevron.down" : "chevron.right")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            }

                            // Section content
                            if sections[index].isExpanded {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(sections[index].content, id: \.self) { line in
                                        Text(LocalizedStringKey(line))
                                            .font(.body)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                            }
                        }

                        Divider()
                    }

                    // Show on startup toggle
                    VStack(spacing: 0) {
                        Toggle(String(localized: "show_on_startup"), isOn: $settings.showHowToPlayOnLaunch)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle(String(localized: "how_to_play_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(String(localized: "how_to_play_done")) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HowToPlayView()
}
