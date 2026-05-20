import SwiftUI

struct BoardView: View {
    @Environment(GameState.self) private var gameState

    var body: some View {
        // TODO: render the MindSweeper grid with tap and long-press handling
        VStack(spacing: 16) {
            Image(systemName: "square.grid.3x3")
                .font(.system(size: 64))
                .foregroundStyle(.tint)
            Text("Board — coming soon")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    BoardView()
        .environment(GameState())
}
