import XCTest
@testable import MindSweeper

final class DeckManagerTests: XCTestCase {

    // MARK: - Preset Loading

    func testMathPresetLoads12Cards() {
        var deck = DeckManager()
        deck.loadPreset(.math)
        XCTAssertEqual(deck.cards.count, 12)
    }

    func testHistoryPresetLoads12Cards() {
        var deck = DeckManager()
        deck.loadPreset(.history)
        XCTAssertEqual(deck.cards.count, 12)
    }

    func testSciencePresetLoads12Cards() {
        var deck = DeckManager()
        deck.loadPreset(.science)
        XCTAssertEqual(deck.cards.count, 12)
    }

    func testVocabPresetLoads12Cards() {
        var deck = DeckManager()
        deck.loadPreset(.vocabulary)
        XCTAssertEqual(deck.cards.count, 12)
    }

    // MARK: - Card Drawing

    func testDrawCardDecrementsCount() {
        var deck = DeckManager()
        deck.loadPreset(.math)
        let countBefore = deck.cards.count
        _ = deck.drawCard()
        XCTAssertEqual(deck.cards.count, countBefore - 1)
    }

    func testDrawCardReturnsNilWhenEmpty() {
        var deck = DeckManager()
        let card = deck.drawCard()
        XCTAssertNil(card)
    }

    // MARK: - Answer Validation

    func testCheckAnswerExactMatch() {
        let deck = DeckManager()
        let card = Card(question: "What is 2 + 2?", answer: "4")
        XCTAssertTrue(deck.checkAnswer(card: card, playerAnswer: "4"))
    }

    func testCheckAnswerIgnoresCase() {
        let deck = DeckManager()
        let card = Card(question: "What is the chemical symbol for gold?", answer: "au")
        XCTAssertTrue(deck.checkAnswer(card: card, playerAnswer: "Au"))
    }

    func testCheckAnswerTrimsWhitespace() {
        let deck = DeckManager()
        let card = Card(question: "What is the square root of 81?", answer: "9")
        XCTAssertTrue(deck.checkAnswer(card: card, playerAnswer: " 9 "))
    }

    func testCheckAnswerReturnsFalseForWrong() {
        let deck = DeckManager()
        let card = Card(question: "What is 2 + 2?", answer: "4")
        XCTAssertFalse(deck.checkAnswer(card: card, playerAnswer: "5"))
    }
}
