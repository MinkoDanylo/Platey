import SwiftUI

/// Text styles from the Figma design system ("iOS/…" text styles), set in Inter.
///
/// Sizes scale with Dynamic Type relative to the matching system text style.
/// Apply with `.textStyle(.headline)`; use `AppFont.inter(_:size:)` for one-off sizes.
enum AppTextStyle: CaseIterable {
    case displayNumber
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case body
    case callout
    case subheadline
    case footnote
    case caption1
    case caption2

    var weight: AppFont.Weight {
        switch self {
        case .displayNumber, .largeTitle, .title1, .title2: .bold
        case .title3, .headline: .semibold
        case .body, .callout, .subheadline, .footnote, .caption1, .caption2: .regular
        }
    }

    var size: CGFloat {
        switch self {
        case .displayNumber: 44
        case .largeTitle: 34
        case .title1: 28
        case .title2: 22
        case .title3: 20
        case .headline: 17
        case .body: 17
        case .callout: 16
        case .subheadline: 15
        case .footnote: 13
        case .caption1: 12
        case .caption2: 11
        }
    }

    /// Line height in points at the default content size.
    var lineHeight: CGFloat {
        switch self {
        case .displayNumber: 48
        case .largeTitle: 41
        case .title1: 34
        case .title2: 28
        case .title3: 25
        case .headline: 22
        case .body: 22
        case .callout: 21
        case .subheadline: 20
        case .footnote: 18
        case .caption1: 16
        case .caption2: 13
        }
    }

    /// Letter spacing in points.
    var tracking: CGFloat {
        switch self {
        case .displayNumber: -0.88
        case .largeTitle: -0.34
        case .title1: -0.28
        case .title2: -0.22
        case .title3: -0.2
        default: 0
        }
    }

    /// System style used to scale this style with Dynamic Type.
    var relativeTo: Font.TextStyle {
        switch self {
        case .displayNumber, .largeTitle: .largeTitle
        case .title1: .title
        case .title2: .title2
        case .title3: .title3
        case .headline: .headline
        case .body: .body
        case .callout: .callout
        case .subheadline: .subheadline
        case .footnote: .footnote
        case .caption1: .caption
        case .caption2: .caption2
        }
    }

    var font: Font {
        AppFont.inter(weight, size: size, relativeTo: relativeTo)
    }
}

enum AppFont {
    /// Inter weights bundled in `resources/fonts` and registered in `UIAppFonts`.
    enum Weight {
        case regular
        case medium
        case semibold
        case bold

        var postScriptName: String {
            switch self {
            case .regular: "Inter-Regular"
            case .medium: "Inter-Medium"
            case .semibold: "Inter-SemiBold"
            case .bold: "Inter-Bold"
            }
        }
    }

    static func inter(_ weight: Weight, size: CGFloat, relativeTo textStyle: Font.TextStyle = .body) -> Font {
        .custom(weight.postScriptName, size: size, relativeTo: textStyle)
    }
}

private struct AppTextStyleModifier: ViewModifier {
    let style: AppTextStyle

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .tracking(style.tracking)
            .environment(\.lineHeight, .multiple(factor: style.lineHeight / style.size))
    }
}

extension View {
    /// Applies a design-system text style (font, letter spacing and line height).
    func textStyle(_ style: AppTextStyle) -> some View {
        modifier(AppTextStyleModifier(style: style))
    }
}
