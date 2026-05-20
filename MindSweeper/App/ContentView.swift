import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            BoardView()
                .navigationTitle("MindSweeper")
        }
    }
}

#Preview {
    ContentView()
}
