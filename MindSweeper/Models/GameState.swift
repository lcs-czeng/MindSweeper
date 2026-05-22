import Foundation
import Observation

@Observable
class GameState {
    var lives: Int = 3
    var score: Int = 0
    var startTime: Date? = nil
    var pendingCell: (row: Int, col: Int)? = nil
    var status: Status = .idle

    enum Status {
        case idle, playing, won, lost
    }

    // TODO: add BoardModel and DeckManager references
}
