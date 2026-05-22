import SwiftUI

@main
struct MindSweeperApp: App {
    @State private var gameState = GameState()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(gameState)
        }
    }
}
