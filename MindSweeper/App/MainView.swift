import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            BoardView()
                .navigationTitle("MindSweeper")
        }
    }
}

#Preview {
    MainView()
        .environment(GameState())
}
