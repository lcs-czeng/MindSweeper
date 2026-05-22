import Foundation

struct BoardModel {
    let rows: Int
    let cols: Int
    private(set) var cells: [[Cell]] = []

    // MARK: - Grid

    /// Build an empty rows×cols grid.
    mutating func createGrid() {
        cells = (0..<rows).map { row in
            (0..<cols).map { col in
                Cell(row: row, col: col)
            }
        }
    }

    /// Randomly place mineCount mines, guaranteeing safeCell is never a mine.
    /// Also pre-calculates neighborCount for every cell.
    mutating func placeMines(count: Int, safe: (row: Int, col: Int)) {
        // Build a list of all positions except the safe cell
        var candidates = (0..<rows).flatMap { row in
            (0..<cols).map { col in (row: row, col: col) }
        }.filter { $0.row != safe.row || $0.col != safe.col }

        // Shuffle and pick the first `count` positions as mines
        candidates.shuffle()
        for pos in candidates.prefix(count) {
            cells[pos.row][pos.col].isMine = true
        }

        // Pre-calculate neighbor counts for every cell
        for row in 0..<rows {
            for col in 0..<cols {
                cells[row][col].neighborCount = countNeighborMines(row: row, col: col)
            }
        }
    }

    // MARK: - Neighbours

    /// Return the number of mines in the 8 cells surrounding (row, col).
    func countNeighborMines(row: Int, col: Int) -> Int {
        var count = 0
        for dr in -1...1 {
            for dc in -1...1 {
                guard dr != 0 || dc != 0 else { continue }   // skip self
                let r = row + dr
                let c = col + dc
                guard r >= 0, r < rows, c >= 0, c < cols else { continue } // skip out of bounds
                if cells[r][c].isMine { count += 1 }
            }
        }
        return count
    }

    // MARK: - Reveal

    /// Flood-fill reveal from (row, col). Stops at cells with neighborCount > 0.
    mutating func cascadeReveal(row: Int, col: Int) {
        guard row >= 0, row < rows, col >= 0, col < cols else { return }
        guard !cells[row][col].isRevealed, !cells[row][col].isMine else { return }

        cells[row][col].isRevealed = true

        // Only expand if this cell has no neighbouring mines
        guard cells[row][col].neighborCount == 0 else { return }

        for dr in -1...1 {
            for dc in -1...1 {
                guard dr != 0 || dc != 0 else { continue }
                cascadeReveal(row: row + dr, col: col + dc)
            }
        }
    }
}
