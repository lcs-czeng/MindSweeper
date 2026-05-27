import SwiftUI

struct QuestionOverlay: View {
    let card: Card
    @Binding var playerAnswer: String
    let onSubmit: (String) -> Void

    @FocusState private var isTextFieldFocused: Bool
    @State private var showHint = false

    var body: some View {
        // TODO: implement full question prompt and answer input UI
        VStack(spacing: 20) {
            Text(card.question)
                .font(.title2)
                .multilineTextAlignment(.center)
            TextField("Your answer", text: $playerAnswer)
                .textFieldStyle(.roundedBorder)
                .focused($isTextFieldFocused)
                .onSubmit {
                    if !playerAnswer.isEmpty { onSubmit(playerAnswer) }
                }
            if let hint = card.hint, !hint.isEmpty {
                VStack(spacing: 8) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showHint.toggle()
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: showHint ? "lightbulb.dotted.fill" : "lightbulb")
                            Text(showHint ? "Hide Hint" : "Show Hint")
                        }
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                    }
                    
                    if showHint {
                        Text(hint)
                            .font(.subheadline)
                            .italic()
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .padding(.vertical, 4)
            }
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

