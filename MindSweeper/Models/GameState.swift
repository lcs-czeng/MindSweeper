import Foundation
import Observation

@Observable
class GameState {

    // MARK: - Nested Types

    enum Status {
        case idle, playing, won, lost
    }

    struct CellPosition: Equatable {
        let row: Int
        let col: Int
    }

    // MARK: - Properties

    private(set) var board: BoardModel
    private let mineCount: Int

    var lives: Int = 3
    var score: Int = 0
    var startTime: Date? = nil
    var pendingCell: CellPosition? = nil
    var status: Status = .idle

    // TODO: add DeckManager reference when issue #5 is merged

    // MARK: - Init

    init(rows: Int = 9, cols: Int = 9, mineCount: Int = 10) {
        self.mineCount = mineCount
        var b = BoardModel(rows: rows, cols: cols)
        b.createGrid()
        self.board = b
    }

    // MARK: - Cell Actions

    /// Called when the player taps an unrevealed cell.
    /// Places mines on the first tap (guaranteeing this cell is safe) and sets it as pending.
    func cellTapped(row: Int, col: Int) {
        guard status == .idle || status == .playing else { return }
        guard !board.cells[row][col].isRevealed,
              !board.cells[row][col].isFlagged else { return }

        // First tap — place mines and start the timer
        if status == .idle {
            board.placeMines(count: mineCount, safe: (row: row, col: col))
            startTime = Date()
            status = .playing
        }

        pendingCell = CellPosition(row: row, col: col)
    }

    /// Toggle a flag on an unrevealed cell (long press).
    func toggleFlag(row: Int, col: Int) {
        guard status == .playing else { return }
        board.toggleFlag(row: row, col: col)
    }

    // MARK: - Answer Actions

    /// Correct answer — reveal the pending cell and award points.
    func applyCorrectAnswer() {
        guard let cell = pendingCell else { return }
        board.cascadeReveal(row: cell.row, col: cell.col)
        score += 10
        pendingCell = nil
        checkWinCondition()
    }

    /// Wrong answer — lose a life. Transitions to .lost when lives hit 0.
    func applyWrongAnswer() {
        guard pendingCell != nil else { return }
        pendingCell = nil
        lives -= 1
        if lives <= 0 {
            status = .lost
        }
    }

    // MARK: - Timer

    /// Elapsed time in seconds since the first tap.
    var elapsedSeconds: Int {
        guard let start = startTime else { return 0 }
        return Int(Date().timeIntervalSince(start))
    }

    // MARK: - Reset

    /// Reset the game back to its initial state, ready for a new round.
    func reset() {
        var freshBoard = BoardModel(rows: board.rows, cols: board.cols)
        freshBoard.createGrid()
        board = freshBoard
        lives = 3
        score = 0
        startTime = nil
        pendingCell = nil
        status = .idle
    }

    // MARK: - Private

    /// Check if all non-mine cells are revealed — if so, the player wins.
    private func checkWinCondition() {
        let allSafeCellsRevealed = board.cells.allSatisfy { row in
            row.allSatisfy { cell in cell.isMine || cell.isRevealed }
        }
        if allSafeCellsRevealed {
            status = .won
        }
    }
}
