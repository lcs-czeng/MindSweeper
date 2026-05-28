import Foundation

struct Cell {
    let row: Int
    let col: Int
    var isMine: Bool = false
    var isRevealed: Bool = false
    var isFlagged: Bool = false
    var neighborCount: Int = 0
}
