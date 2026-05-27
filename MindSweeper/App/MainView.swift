import SwiftUI

struct MainView: View {

    // MARK: - Stored properties

    @State var gameState = GameState()

    // MARK: - Body

    var body: some View {
        NavigationStack {
            SubjectPickerView(gameState: gameState)
                .navigationTitle("MindSweeper")
        }
    }
}

#Preview {
    MainView()
}
