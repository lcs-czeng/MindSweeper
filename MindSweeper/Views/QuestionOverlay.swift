import SwiftUI

struct QuestionOverlay: View {
    let card: Card
    @Binding var playerAnswer: String
    let onSubmit: (String) -> Void

    var body: some View {
        // TODO: implement full question prompt and answer input UI
        VStack(spacing: 20) {
            Text(card.question)
                .font(.title2)
                .multilineTextAlignment(.center)
            TextField("Your answer", text: $playerAnswer)
                .textFieldStyle(.roundedBorder)
            Button("Submit") {
                onSubmit(playerAnswer)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    QuestionOverlay(
        card: Card(question: "What is 7 × 8?", answer: "56"),
        playerAnswer: .constant(""),
        onSubmit: { _ in }
    )
}
