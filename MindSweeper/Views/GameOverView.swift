import SwiftUI

struct GameOverView: View {

    // MARK: - Stored properties

    var gameState: GameState

    // MARK: - Computed properties

    private var isWin: Bool {
        gameState.status == .won
    }

    private var outcomeColour: Color {
        if isWin {
            return .green
        } else {
            return .red
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 24) {
            header
            scoreCard
            Spacer()
            playAgainButton
        }
        .padding()
    }

    // MARK: - Subviews

    private var header: some View {
        VStack(spacing: 8) {
            Image(systemName: isWin ? "trophy.fill" : "xmark.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(outcomeColour)
            Text(isWin ? "You Win!" : "Game Over")
                .font(.largeTitle)
                .bold()
            Text(isWin ? "You revealed all safe cells." : "You ran out of lives.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 16)
    }

    private var scoreCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "star.fill")
                .font(.system(size: 36))
                .foregroundStyle(.white)
            Text("Score: \(gameState.score)")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(outcomeColour.gradient)
                .shadow(color: outcomeColour.opacity(0.4), radius: 8, x: 0, y: 4)
        )
    }

    private var playAgainButton: some View {
        Button {
            gameState.reset()
        } label: {
            VStack(spacing: 12) {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 36))
                    .foregroundStyle(.white)
                Text("Play Again")
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.accentColor.gradient)
                    .shadow(color: Color.accentColor.opacity(0.4), radius: 8, x: 0, y: 4)
            )
        }
    }
}

#Preview {
    let wonState = GameState()
    wonState.score = 80
    wonState.status = .won
    return GameOverView(gameState: wonState)
}
