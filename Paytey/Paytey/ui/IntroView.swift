//
//  IntroView.swift
//  Paytey
//
//  Created by Мінько Данило on 09.10.2026.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject private var navigator: Navigator
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Logo has faded and scaled in at the center.
    @State private var isLogoVisible = false
    /// Logo is flying up into the Dynamic Island.
    @State private var isLogoRaised = false
    /// Logo has faded out inside the Dynamic Island.
    @State private var isLogoGone = false

    private let logoSize: CGFloat = 200
    /// Final scale so the logo ends about as tall as the Dynamic Island (~36pt).
    private let islandScale: CGFloat = 0.18

    var body: some View {
        GeometryReader { geometry in
            // The Dynamic Island sits centered in the top safe-area inset, so its center is
            // half the inset above the safe area's top edge (negative y in these coordinates).
            let islandY = -geometry.safeAreaInsets.top / 2

            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: logoSize, height: logoSize)
                .scaleEffect(isLogoRaised ? islandScale : (isLogoVisible ? 1 : 0.6))
                .opacity(isLogoVisible && !isLogoGone ? 1 : 0)
                .position(
                    x: geometry.size.width / 2,
                    y: isLogoRaised ? islandY : geometry.size.height / 2
                )
        }
        .background(Color.appBackground.ignoresSafeArea())
        .task { await animateLogo() }
    }

    /// Pops the logo in at the center, then quickly pulls it up into the Dynamic Island.
    private func animateLogo() async {
        guard !isLogoGone else { return }

        if reduceMotion {
            withAnimation(.easeInOut(duration: 0.3)) { isLogoVisible = true }
            try? await Task.sleep(for: .seconds(0.8))
            withAnimation(.easeInOut(duration: 0.3)) { isLogoGone = true }
            return
        }

        withAnimation(.spring(duration: 0.5, bounce: 0.35)) {
            isLogoVisible = true
        }
        try? await Task.sleep(for: .seconds(0.7))

        // Ease in so it accelerates upward, like it's being sucked into the island.
        withAnimation(.easeIn(duration: 0.35)) {
            isLogoRaised = true
        }
        // Fade out during the last part of the flight, as the logo reaches the island.
        withAnimation(.easeIn(duration: 0.15).delay(0.22)) {
            isLogoGone = true
        }
    }
}

#Preview {
    IntroView()
        .environmentObject(Navigator())
}
