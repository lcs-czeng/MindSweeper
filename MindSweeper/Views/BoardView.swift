import SwiftUI

struct BoardView: View {

    // MARK: - Stored properties

    let subject: DeckManager.Subject
    var gameState: GameState

    @State private var deckManager = DeckManager()

    // MARK: - Body

    var body: some View {
        // TODO: render the MindSweeper grid with tap and long-press handling
        VStack(spacing: 16) {
            Image(systemName: "square.grid.3x3")
                .font(.system(size: 64))
                .foregroundStyle(.tint)
            Text("Board — coming soon")
                .foregroundStyle(.secondary)
        }
        .onAppear {
            deckManager.loadPreset(subject)
        }
        .navigationTitle(subject.rawValue.capitalized)
    }
}

#Preview {
    NavigationStack {
        BoardView(subject: .math, gameState: GameState())
    }
}
