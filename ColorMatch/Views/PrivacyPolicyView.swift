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
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Text("Last Updated: December 28, 2025")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Divider()

                // Introduction
                VStack(alignment: .leading, spacing: 12) {
                    Text("Introduction")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("ColorMatch is an educational game designed for children to learn about RGB color composition. We take your privacy seriously, especially when it comes to children's data.")
                        .font(.body)
                }

                // Data Collection
                VStack(alignment: .leading, spacing: 12) {
                    Text("Data Collection")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("ColorMatch does NOT collect, store, or transmit any personal information. The app:")
                        .font(.body)

                    VStack(alignment: .leading, spacing: 8) {
                        bulletPoint("Does not require registration or account creation")
                        bulletPoint("Does not collect names, email addresses, or any personal data")
                        bulletPoint("Does not use analytics or tracking services")
                        bulletPoint("Does not contain advertisements")
                        bulletPoint("Does not share any information with third parties")
                    }
                }

                // Local Storage
                VStack(alignment: .leading, spacing: 12) {
                    Text("Local Storage")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("The app stores the following preferences locally on your device only:")
                        .font(.body)

                    VStack(alignment: .leading, spacing: 8) {
                        bulletPoint("Difficulty level setting")
                        bulletPoint("Show/hide color values preference")
                        bulletPoint("First launch tutorial preference")
                    }

                    Text("This data never leaves your device and is not accessible to us or any third party.")
                        .font(.body)
                        .italic()
                }

                // Children's Privacy
                VStack(alignment: .leading, spacing: 12) {
                    Text("Children's Privacy (COPPA Compliance)")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("ColorMatch is designed for children and complies with the Children's Online Privacy Protection Act (COPPA). We do not knowingly collect any personal information from children under 13.")
                        .font(.body)

                    Text("The app is completely offline and does not require internet connection to function.")
                        .font(.body)
                        .fontWeight(.medium)
                }

                // Third-Party Services
                VStack(alignment: .leading, spacing: 12) {
                    Text("Third-Party Services")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("ColorMatch does not integrate with any third-party services, SDKs, or frameworks that collect data.")
                        .font(.body)
                }

                // Changes to Privacy Policy
                VStack(alignment: .leading, spacing: 12) {
                    Text("Changes to This Privacy Policy")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy in the app and updating the \"Last Updated\" date.")
                        .font(.body)
                }

                // Contact
                VStack(alignment: .leading, spacing: 12) {
                    Text("Contact Us")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("If you have any questions about this Privacy Policy, please contact us:")
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
                Text("By using ColorMatch, you agree to this Privacy Policy.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
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
