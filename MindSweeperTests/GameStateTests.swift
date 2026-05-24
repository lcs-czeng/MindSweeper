import XCTest
@testable import MindSweeper

final class GameStateTests: XCTestCase {

    // MARK: - Initial state

    func testInitialStatus_isIdle() {
        let state = GameState()
        XCTAssertEqual(state.status, .idle)
    }

    func testInitialLives_isThree() {
        let state = GameState()
        XCTAssertEqual(state.lives, 3)
    }

    func testInitialScore_isZero() {
        let state = GameState()
        XCTAssertEqual(state.score, 0)
    }

    // MARK: - Cell tapping

    func testFirstTap_transitionsToPlaying() {
        let state = GameState()
        state.cellTapped(row: 4, col: 4)
        XCTAssertEqual(state.status, .playing)
    }

    func testFirstTap_setsPendingCell() {
        let state = GameState()
        state.cellTapped(row: 4, col: 4)
        XCTAssertNotNil(state.pendingCell)
    }

    // MARK: - Correct answer

    func testCorrectAnswer_incrementsScoreByTen() {
        let state = GameState()
        state.cellTapped(row: 4, col: 4)
        state.applyCorrectAnswer()
        XCTAssertEqual(state.score, 10)
    }

    func testCorrectAnswer_clearsPendingCell() {
        let state = GameState()
        state.cellTapped(row: 4, col: 4)
        state.applyCorrectAnswer()
        XCTAssertNil(state.pendingCell)
    }

    // MARK: - Wrong answer

    func testWrongAnswer_decrementsLives() {
        let state = GameState()
        state.cellTapped(row: 4, col: 4)
        state.applyWrongAnswer()
        XCTAssertEqual(state.lives, 2)
    }

    func testWrongAnswer_clearsPendingCell() {
        let state = GameState()
        state.cellTapped(row: 4, col: 4)
        state.applyWrongAnswer()
        XCTAssertNil(state.pendingCell)
    }

    func testThreeWrongAnswers_setsStatusToLost() {
        let state = GameState()
        // Tap the same unrevealed cell 3 times (wrong answer never reveals it)
        state.cellTapped(row: 4, col: 4)
        state.applyWrongAnswer()
        state.cellTapped(row: 4, col: 4)
        state.applyWrongAnswer()
        state.cellTapped(row: 4, col: 4)
        state.applyWrongAnswer()
        XCTAssertEqual(state.status, .lost)
    }

    // MARK: - Win condition

    func testAllSafeCellsRevealed_setsStatusToWon() {
        // 2x2 board with 0 mines — cascade reveal fills the whole board
        let state = GameState(rows: 2, cols: 2, mineCount: 0)
        state.cellTapped(row: 0, col: 0)
        state.applyCorrectAnswer()
        XCTAssertEqual(state.status, .won)
    }
}
