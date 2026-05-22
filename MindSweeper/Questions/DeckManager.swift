import Foundation

struct DeckManager {
    private(set) var cards: [Card] = []

    // MARK: - Loading

    /// Load a preset deck by subject.
    mutating func loadPreset(_ subject: Subject) {
        // TODO: assign the matching static deck from Data/
    }

    enum Subject: String, CaseIterable {
        case math, history, science, vocabulary
    }

    // MARK: - Drawing

    /// Draw a random card and remove it from the pool. Returns nil when empty.
    mutating func drawCard() -> Card? {
        // TODO: implement
        return nil
    }

    // MARK: - Answer Checking

    /// Normalise a raw answer string (trim, lowercase, collapse whitespace).
    func normalizeAnswer(_ raw: String) -> String {
        // TODO: implement
        return raw.trimmingCharacters(in: .whitespaces).lowercased()
    }

    /// Return true if the player's answer matches the card's answer.
    func checkAnswer(card: Card, playerAnswer: String) -> Bool {
        // TODO: implement
        return normalizeAnswer(playerAnswer) == normalizeAnswer(card.answer)
    }
}
