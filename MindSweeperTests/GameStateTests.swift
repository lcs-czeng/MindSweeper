import XCTest
@testable import MindSweeper

final class GameStateTests: XCTestCase {

    // MARK: - Initial state

    func testInitialStatus_isIdle() async {
        let status = await MainActor.run { GameState().status }
        XCTAssertEqual(status, .idle)
    }

    func testInitialLives_isThree() async {
        let lives = await MainActor.run { GameState().lives }
        XCTAssertEqual(lives, 3)
    }

    func testInitialScore_isZero() async {
        let score = await MainActor.run { GameState().score }
        XCTAssertEqual(score, 0)
    }

    // MARK: - Cell tapping

    func testFirstTap_transitionsToPlaying() async {
        let status = await MainActor.run {
            let state = GameState()
            state.cellTapped(row: 4, col: 4)
            return state.status
        }
        XCTAssertEqual(status, .playing)
    }

    func testFirstTap_setsPendingCell() async {
        let pending = await MainActor.run {
            let state = GameState()
            state.cellTapped(row: 4, col: 4)
            return state.pendingCell
        }
        XCTAssertNotNil(pending)
    }

    // MARK: - Correct answer

    func testCorrectAnswer_incrementsScoreByTen() async {
        let score = await MainActor.run {
            let state = GameState()
            state.cellTapped(row: 4, col: 4)
            state.applyCorrectAnswer()
            return state.score
        }
        XCTAssertEqual(score, 10)
    }

    func testCorrectAnswer_clearsPendingCell() async {
        let pending = await MainActor.run {
            let state = GameState()
            state.cellTapped(row: 4, col: 4)
            state.applyCorrectAnswer()
            return state.pendingCell
        }
        XCTAssertNil(pending)
    }

    // MARK: - Wrong answer

    func testWrongAnswer_decrementsLives() async {
        let lives = await MainActor.run {
            let state = GameState()
            state.cellTapped(row: 4, col: 4)
            state.applyWrongAnswer()
            return state.lives
        }
        XCTAssertEqual(lives, 2)
    }

    func testWrongAnswer_clearsPendingCell() async {
        let pending = await MainActor.run {
            let state = GameState()
            state.cellTapped(row: 4, col: 4)
            state.applyWrongAnswer()
            return state.pendingCell
        }
        XCTAssertNil(pending)
    }

    func testThreeWrongAnswers_setsStatusToLost() async {
        let status = await MainActor.run {
            let state = GameState()
            state.cellTapped(row: 4, col: 4)
            state.applyWrongAnswer()
            state.cellTapped(row: 4, col: 4)
            state.applyWrongAnswer()
            state.cellTapped(row: 4, col: 4)
            state.applyWrongAnswer()
            return state.status
        }
        XCTAssertEqual(status, .lost)
    }

    // MARK: - Win condition

    func testAllSafeCellsRevealed_setsStatusToWon() async {
        // 2x2 board with 0 mines — cascade reveal fills the whole board
        let status = await MainActor.run {
            let state = GameState(rows: 2, cols: 2, mineCount: 0)
            state.cellTapped(row: 0, col: 0)
            state.applyCorrectAnswer()
            return state.status
        }
        XCTAssertEqual(status, .won)
    }
}
