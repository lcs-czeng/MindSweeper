import Foundation
import Observation

@Observable
class GameState {

    enum Status {
        case idle, playing, won, lost
    }

    struct CellPosition: Equatable {
        let row: Int
        let col: Int
    }

    private(set) var board: BoardModel
    private let mineCount: Int

    var lives: Int = 3
    var score: Int = 0
    var startTime: Date? = nil
    var pendingCell: CellPosition? = nil
    var status: Status = .idle

    init(rows: Int = 9, cols: Int = 9, mineCount: Int = 10) {
        self.mineCount = mineCount
        var b = BoardModel(rows: rows, cols: cols)
        b.createGrid()
        self.board = b
    }

    // MARK: - Cell Actions

    func cellTapped(row: Int, col: Int) {
        guard status == .idle || status == .playing else { return }
        guard !board.cells[row][col].isRevealed,
              !board.cells[row][col].isFlagged else { return }

        if status == .idle {
            board.placeMines(count: mineCount, safe: (row: row, col: col))
            startTime = Date()
            status = .playing
        }

        // NEW: Check if the player stepped on a bomb!
        if board.cells[row][col].isMine {
            board.revealAllBombs()               // Reveal ALL bombs to the player
            status = .lost                       // Transition to lost immediately
            pendingCell = nil                    // Clear any questions
            return
        }

        pendingCell = CellPosition(row: row, col: col)
    }

    func toggleFlag(row: Int, col: Int) {
        guard status == .idle || status == .playing else { return }
        board.toggleFlag(row: row, col: col)
    }

    // MARK: - Answer Actions

    func applyCorrectAnswer() {
        guard let cell = pendingCell else { return }
        board.cascadeReveal(row: cell.row, col: cell.col)
        score += 10
        pendingCell = nil
        checkWinCondition()
    }

    func applyWrongAnswer() {
        guard pendingCell != nil else { return }
        pendingCell = nil
        lives -= 1
        if lives <= 0 {
            status = .lost
            board.revealAllBombs() // Also show all bombs if they run out of lives!
        }
    }

    // MARK: - Timer

    var elapsedSeconds: Int {
        guard let start = startTime else { return 0 }
        return Int(Date().timeIntervalSince(start))
    }

    // MARK: - Private

    private func checkWinCondition() {
        let allSafeCellsRevealed = board.cells.allSatisfy { row in
            row.allSatisfy { cell in cell.isMine || cell.isRevealed }
        }
        if allSafeCellsRevealed {
            status = .won
        }
    }
}

