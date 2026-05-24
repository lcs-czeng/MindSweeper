import SwiftUI

struct SubjectPickerView: View {

    // MARK: - Stored properties

    var gameState: GameState

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            Text("Choose a Subject")
                .font(.title)
                .bold()
                .padding(.bottom, 8)

            NavigationLink(destination: BoardView(subject: .math, gameState: gameState)) {
                SubjectButton(label: "Math")
            }

            NavigationLink(destination: BoardView(subject: .history, gameState: gameState)) {
                SubjectButton(label: "History")
            }

            NavigationLink(destination: BoardView(subject: .science, gameState: gameState)) {
                SubjectButton(label: "Science")
            }

            NavigationLink(destination: BoardView(subject: .vocabulary, gameState: gameState)) {
                SubjectButton(label: "Vocabulary")
            }
        }
        .padding()
    }
}

// MARK: - Subviews

private struct SubjectButton: View {

    // MARK: - Stored properties

    let label: String

    // MARK: - Body

    var body: some View {
        Text(label)
            .font(.title2)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        SubjectPickerView(gameState: GameState())
    }
}
