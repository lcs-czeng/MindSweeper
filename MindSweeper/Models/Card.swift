import Foundation

struct Card: Identifiable {
    let id: UUID
    let question: String
    let answer: String
    var hint: String?

    init(question: String, answer: String, hint: String? = nil) {
        self.id = UUID()
        self.question = question
        self.answer = answer
        self.hint = hint
    }
}
