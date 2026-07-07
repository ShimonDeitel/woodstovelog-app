import SwiftUI

/// Bespoke palette for Woodstove Log — tuned for its own domain, not shared.
enum Theme {
    static let accent = Color(red: 0.72, green: 0.32, blue: 0.10)
    static let accentSoft = Color(red: 0.95, green: 0.55, blue: 0.15)
    static let background = Color(red: 0.10, green: 0.07, blue: 0.05)
    static let card = Color(red: 0.10, green: 0.07, blue: 0.05).opacity(0.92)

    static let titleFont = Font.system(.largeTitle, design: .serif).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
