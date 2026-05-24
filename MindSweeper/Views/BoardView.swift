import SwiftUI
import Combine

struct BoardView: View {
    @Environment(GameState.self) private var gameState
    
    // Manage local deck for drawing questions
    @State private var deck = DeckManager()
    @State private var currentCard: Card?
    
    // Sheet presentation and answer state
    @State private var isShowingQuestion = false
    @State private var playerAnswer = ""
    
    // HUD Timer
    @State private var timeString = "00:00"
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // Explicitly define 9 flexible columns for a 9x9 layout
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 9)

    var body: some View {
        VStack(spacing: 20) {
            // MARK: - HUD
            HStack {
                Text("❤️ \(gameState.lives)")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("Score: \(gameState.score)")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("⏱ \(timeString)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            .padding(.top, 10)

            Spacer()

            // MARK: - 9x9 Flattened Grid
            // Using a single flat loop fixes the SwiftUI multi-row rendering bug
            let totalCells = gameState.board.rows * gameState.board.cols
            
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(0..<totalCells, id: \.self) { index in
                    // Calculate the exact row and column from the flat index
                    let row = index / gameState.board.cols
                    let col = index % gameState.board.cols
                    
                    // Safely fetch the cell from the 2D matrix
                    let cell = gameState.board.cells[row][col]
                    
                    CellTile(cell: cell)
                        .onTapGesture {
                            handleTap(row: row, col: col)
                        }
                        .onLongPressGesture {
                            gameState.toggleFlag(row: row, col: col)
                        }
                }
            }
            .padding(.horizontal, 12)
            
            Spacer()
        }
        .onAppear {
            deck.loadPreset(.math)
        }
        .onReceive(timer) { _ in
            if gameState.status == .playing {
                let seconds = gameState.elapsedSeconds
                timeString = String(format: "%02d:%02d", seconds / 60, seconds % 60)
            }
        }
        // MARK: - Question Sheet
        .sheet(isPresented: $isShowingQuestion) {
            if let card = currentCard {
                QuestionOverlay(
                    card: card,
                    playerAnswer: $playerAnswer,
                    onSubmit: { answer in
                        isShowingQuestion = false
                        if deck.checkAnswer(card: card, playerAnswer: answer) {
                            gameState.applyCorrectAnswer()
                        } else {
                            gameState.applyWrongAnswer()
                        }
                    }
                )
            }
        }
    }
    
    // MARK: - Tap Handling
    private func handleTap(row: Int, col: Int) {
        let cell = gameState.board.cells[row][col]
        guard !cell.isRevealed, !cell.isFlagged else { return }
        
        gameState.cellTapped(row: row, col: col)
        
        if deck.cards.isEmpty {
            deck.loadPreset(.math)
        }
        
        if let card = deck.drawCard() {
            currentCard = card
            playerAnswer = ""
            isShowingQuestion = true
        }
    }
}

// MARK: - Cell Subview
struct CellTile: View {
    let cell: Cell
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(cell.isRevealed ? Color(UIColor.systemGray5) : Color.gray.opacity(0.6))
                .aspectRatio(1.0, contentMode: .fill) // Keeps tiles perfectly square
                .cornerRadius(4)
            
            if cell.isRevealed {
                if cell.isMine {
                    Image(systemName: "burst.fill")
                        .font(.headline)
                        .foregroundColor(.red)
                } else if cell.neighborCount > 0 {
                    Text("\(cell.neighborCount)")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(numberColor(cell.neighborCount))
                }
            } else if cell.isFlagged {
                Image(systemName: "flag.fill")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
    
    private func numberColor(_ count: Int) -> Color {
        switch count {
        case 1: return .blue
        case 2: return .green
        case 3: return .red
        case 4: return .purple
        case 5: return .orange
        case 6: return .cyan
        case 7: return .black
        default: return .gray
        }
    }
}

#Preview {
    BoardView()
        .environment(GameState())
}

