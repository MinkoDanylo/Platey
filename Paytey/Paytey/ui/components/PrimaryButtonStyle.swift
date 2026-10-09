import SwiftUI

/// Figma "Button/Primary": full-width, 50pt tall, accent fill, 14pt corners.
struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(.headline)
            .foregroundStyle(.onAccent)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.accent, in: .rect(cornerRadius: 14))
            .opacity(isEnabled ? (configuration.isPressed ? 0.8 : 1) : 0.4)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}
