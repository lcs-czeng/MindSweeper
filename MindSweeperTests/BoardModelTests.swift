import XCTest
@testable import MindSweeper

final class BoardModelTests: XCTestCase {

    // MARK: - Grid creation

    func testCreateGrid_producesCorrectRowCount() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        XCTAssertEqual(board.cells.count, 9)
    }

    func testCreateGrid_producesCorrectColCount() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        XCTAssertEqual(board.cells[0].count, 9)
    }

    func testCreateGrid_allCellsStartUnrevealed() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        let anyRevealed = board.cells.flatMap { $0 }.contains { $0.isRevealed }
        XCTAssertFalse(anyRevealed)
    }

    func testCreateGrid_noMinesPlacedYet() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        let anyMine = board.cells.flatMap { $0 }.contains { $0.isMine }
        XCTAssertFalse(anyMine)
    }

    // MARK: - Mine placement

    func testPlaceMines_correctCount() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        board.placeMines(count: 10, safe: (row: 4, col: 4))
        let mineCount = board.cells.flatMap { $0 }.filter { $0.isMine }.count
        XCTAssertEqual(mineCount, 10)
    }

    func testPlaceMines_safeCellIsNeverAMine() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        board.placeMines(count: 10, safe: (row: 0, col: 0))
        XCTAssertFalse(board.cells[0][0].isMine)
    }

    func testPlaceMines_safeCellInCorner() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        board.placeMines(count: 10, safe: (row: 8, col: 8))
        XCTAssertFalse(board.cells[8][8].isMine)
    }

    // MARK: - Flagging

    func testToggleFlag_flagsUnrevealedCell() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        board.toggleFlag(row: 0, col: 0)
        XCTAssertTrue(board.cells[0][0].isFlagged)
    }

    func testToggleFlag_unflags() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        board.toggleFlag(row: 0, col: 0)
        board.toggleFlag(row: 0, col: 0)
        XCTAssertFalse(board.cells[0][0].isFlagged)
    }

    func testToggleFlag_doesNothingOnRevealedCell() {
        var board = BoardModel(rows: 9, cols: 9)
        board.createGrid()
        // cascadeReveal on a mine-free board reveals the cell
        board.cascadeReveal(row: 0, col: 0)
        board.toggleFlag(row: 0, col: 0)
        XCTAssertFalse(board.cells[0][0].isFlagged)
    }

    // MARK: - Cascade reveal

    func testCascadeReveal_revealsTargetCell() {
        var board = BoardModel(rows: 3, cols: 3)
        board.createGrid()
        board.cascadeReveal(row: 1, col: 1)
        XCTAssertTrue(board.cells[1][1].isRevealed)
    }

    func testCascadeReveal_floodFillsWhenNoMines() {
        var board = BoardModel(rows: 3, cols: 3)
        board.createGrid()
        // No mines — all neighborCounts are 0, cascade fills the whole board
        board.cascadeReveal(row: 1, col: 1)
        let revealedCount = board.cells.flatMap { $0 }.filter { $0.isRevealed }.count
        XCTAssertEqual(revealedCount, 9)
    }
}
