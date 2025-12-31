//
//  PrivacyPolicyView.swift
//  ColorMatch
//
//  Created by Madji on 28.12.25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("privacy_policy_title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Text("last_updated")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Divider()

                // Introduction
                VStack(alignment: .leading, spacing: 12) {
                    Text("privacy_introduction")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("privacy_intro_text")
                        .font(.body)
                }

                // Data Collection
                VStack(alignment: .leading, spacing: 12) {
                    Text("privacy_data_collection")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("privacy_data_text")
                        .font(.body)

                    VStack(alignment: .leading, spacing: 8) {
                        bulletPoint(String(localized: "privacy_no_registration"))
                        bulletPoint(String(localized: "privacy_no_personal_data"))
                        bulletPoint(String(localized: "privacy_no_analytics"))
                        bulletPoint(String(localized: "privacy_no_ads"))
                        bulletPoint(String(localized: "privacy_no_third_party"))
                    }
                }

                // Local Storage
                VStack(alignment: .leading, spacing: 12) {
                    Text("privacy_local_storage")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("privacy_local_text")
                        .font(.body)

                    VStack(alignment: .leading, spacing: 8) {
                        bulletPoint(String(localized: "privacy_storage_difficulty"))
                        bulletPoint(String(localized: "privacy_storage_values"))
                        bulletPoint(String(localized: "privacy_storage_tutorial"))
                    }

                    Text("privacy_local_note")
                        .font(.body)
                        .italic()
                }

                // Children's Privacy
                VStack(alignment: .leading, spacing: 12) {
                    Text("privacy_coppa")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("privacy_coppa_text")
                        .font(.body)

                    Text("privacy_offline")
                        .font(.body)
                        .fontWeight(.medium)
                }

                // Third-Party Services
                VStack(alignment: .leading, spacing: 12) {
                    Text("privacy_third_party_services")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("privacy_third_party_text")
                        .font(.body)
                }

                // Changes to Privacy Policy
                VStack(alignment: .leading, spacing: 12) {
                    Text("privacy_changes")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("privacy_changes_text")
                        .font(.body)
                }

                // Contact
                VStack(alignment: .leading, spacing: 12) {
                    Text("privacy_contact_us")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("privacy_contact_text")
                        .font(.body)

                    Link(destination: URL(string: "mailto:hello@mladenraykov.com")!) {
                        HStack {
                            Image(systemName: "envelope")
                            Text("hello@mladenraykov.com")
                        }
                        .font(.body)
                        .foregroundColor(.blue)
                    }

                    Link(destination: URL(string: "https://mladenraykov.com")!) {
                        HStack {
                            Image(systemName: "globe")
                            Text("mladenraykov.com")
                        }
                        .font(.body)
                        .foregroundColor(.blue)
                    }
                }

                Divider()

                // Footer
                Text("privacy_footer")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle(String(localized: "privacy_policy_title"))
        .navigationBarTitleDisplayMode(.inline)
    }

    private func bulletPoint(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.body)
            Text(text)
                .font(.body)
        }
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
