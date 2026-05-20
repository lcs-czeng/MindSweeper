# MindSweeper

A Minesweeper game where players must answer study flashcard questions to reveal cells.

## Getting Started

1. Clone the repository
2. Open `MindSweeper.xcodeproj` in Xcode
3. Select an iPhone simulator
4. Press ▶ to build and run

## Project Structure

```
MindSweeper/
├── App/            # Entry point and root view
├── Game/           # Board logic, mine placement, cascade reveal
├── Questions/      # Deck management and answer checking
├── Views/          # SwiftUI views and overlays
├── Models/         # GameState, Card, Cell
└── Data/           # Preset question decks
```

## Preset Decks

| Subject    | Cards |
| ---------- | ----- |
| Math       | 12    |
| History    | 12    |
| Science    | 12    |
| Vocabulary | 12    |

## Tech Stack

- Swift
- SwiftUI
- iOS 17+
- XCTest

## Team

- Courage
- Thomas
- Michael
