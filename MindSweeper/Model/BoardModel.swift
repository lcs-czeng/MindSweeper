import Foundation

struct BoardModel {
    let rows: Int
    let cols: Int
    private(set) var cells: [[Cell]] = []

    // MARK: - Grid

    mutating func createGrid() {
        cells = (0..<rows).map { row in
            (0..<cols).map { col in
                Cell(row: row, col: col)
            }
        }
    }

    mutating func placeMines(count: Int, safe: (row: Int, col: Int)) {
        var candidates = (0..<rows).flatMap { row in
            (0..<cols).map { col in (row: row, col: col) }
        }.filter { $0.row != safe.row || $0.col != safe.col }

        candidates.shuffle()
        for pos in candidates.prefix(count) {
            cells[pos.row][pos.col].isMine = true
        }

        for row in 0..<rows {
            for col in 0..<cols {
                cells[row][col].neighborCount = countNeighborMines(row: row, col: col)
            }
        }
    }

    // MARK: - Neighbours

    func countNeighborMines(row: Int, col: Int) -> Int {
        var count = 0
        for dr in -1...1 {
            for dc in -1...1 {
                guard dr != 0 || dc != 0 else { continue }
                let r = row + dr
                let c = col + dc
                guard r >= 0, r < rows, c >= 0, c < cols else { continue }
                if cells[r][c].isMine { count += 1 }
            }
        }
        return count
    }

    // MARK: - Flag

    mutating func toggleFlag(row: Int, col: Int) {
        guard row >= 0, row < rows, col >= 0, col < cols else { return }
        guard !cells[row][col].isRevealed else { return }
        cells[row][col].isFlagged.toggle()
    }

    // MARK: - Reveal

    mutating func cascadeReveal(row: Int, col: Int) {
        guard row >= 0, row < rows, col >= 0, col < cols else { return }
        guard !cells[row][col].isRevealed, !cells[row][col].isMine else { return }

        cells[row][col].isRevealed = true

        guard cells[row][col].neighborCount == 0 else { return }

        for dr in -1...1 {
            for dc in -1...1 {
                guard dr != 0 || dc != 0 else { continue }
                cascadeReveal(row: row + dr, col: col + dc)
            }
        }
    }

    // MARK: - Game Over Reveal

    /// Immediately reveals ALL bombs on the board when the game is lost
    mutating func revealAllBombs() {
        for r in 0..<rows {
            for c in 0..<cols {
                if cells[r][c].isMine {
                    cells[r][c].isRevealed = true
                }
            }
        }
    }
}
