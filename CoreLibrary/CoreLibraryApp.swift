//
//  CoreLibraryApp.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-01.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

@main
struct CoreLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }

            Button("Open bumble") {
                router.showScreen(.fullScreenCover) { _ in
                    BumbleHomeView()
                }
            }

            Button("Open Netflix") {
                router.showScreen(.fullScreenCover) { _ in
                    NetflixHomeView()
                }
            }
        }
        .background(Color.black.opacity(0.95))
    }

    @Environment(\.router) var router
}

// Allow swipe gesture pop
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
