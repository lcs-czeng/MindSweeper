import SwiftUI

struct GameOverView: View {

    // MARK: - Stored properties

    var gameState: GameState

    // MARK: - Body

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            outcomeSection

            scoreSection

            Spacer()

            playAgainButton
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColour.gradient.opacity(0.15).ignoresSafeArea())
    }

    // MARK: - Subviews

    private var outcomeSection: some View {
        VStack(spacing: 16) {
            Text(outcomeEmoji)
                .font(.system(size: 80))

            Text(outcomeTitle)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(backgroundColour)

            Text(outcomeMessage)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private var scoreSection: some View {
        VStack(spacing: 8) {
            Text("Final Score")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text("\(gameState.score)")
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundStyle(backgroundColour)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColour.opacity(0.1))
        )
    }

    private var playAgainButton: some View {
        Button {
            gameState.reset()
        } label: {
            Text("Play Again")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColour.gradient)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    // MARK: - Computed properties

    private var isWin: Bool {
        gameState.status == .won
    }

    private var outcomeEmoji: String {
        if isWin {
            return "🎉"
        } else {
            return "💀"
        }
    }

    private var outcomeTitle: String {
        if isWin {
            return "You Win!"
        } else {
            return "Game Over"
        }
    }

    private var outcomeMessage: String {
        if isWin {
            return "You revealed all safe cells. Well done!"
        } else {
            return "You ran out of lives. Better luck next time!"
        }
    }

    private var backgroundColour: Color {
        if isWin {
            return .green
        } else {
            return .red
        }
    }
}

#Preview {
    let wonState = GameState()
    wonState.score = 80
    wonState.status = .won
    return GameOverView(gameState: wonState)
}
