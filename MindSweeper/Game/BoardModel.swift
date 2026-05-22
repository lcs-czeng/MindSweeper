import Foundation

struct BoardModel {
    let rows: Int
    let cols: Int
    private(set) var cells: [[Cell]] = []

    // MARK: - Grid

    /// Build an empty rows×cols grid.
    mutating func createGrid() {
        // TODO: implement
    }

    /// Randomly place mineCount mines, guaranteeing safeCell is never a mine.
    mutating func placeMines(count: Int, safe: (row: Int, col: Int)) {
        // TODO: implement
    }

    // MARK: - Neighbours

    /// Return the number of mines in the 8 cells surrounding (row, col).
    func countNeighborMines(row: Int, col: Int) -> Int {
        // TODO: implement
        return 0
    }

    // MARK: - Reveal

    /// Flood-fill reveal from (row, col). Stops at cells with neighborCount > 0.
    mutating func cascadeReveal(row: Int, col: Int) {
        // TODO: implement
    }
}
