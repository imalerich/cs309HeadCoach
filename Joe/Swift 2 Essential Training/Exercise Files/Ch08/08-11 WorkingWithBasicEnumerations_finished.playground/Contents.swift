//: ## Working With Basic Enumerations

import Foundation

enum Direction {
  
  case Up
  case Down
  case Left
  case Right
  
}

let upDirection = Direction.Up
let downDirection: Direction = .Down

func moveInDirection(direction: Direction) {
  print("Moved one space \(direction)")
}

moveInDirection(.Left)

enum Heading: Int {
  
  case North, South, East, West
  
}

let heading = Heading(rawValue: 3)!
print(heading)

let invalidHeading = Heading(rawValue: 10)

enum ClockPosition: Double {
  
  case One = 1
  case OneThirty = 1.5
  case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Eleven, Twelve
  
}

let nineOClock = ClockPosition.Nine
nineOClock.rawValue

enum Proverb: String {
  
  case Fortune = "Fortune favors the bold"
  case Late = "Better late than never"
  case Practice = "Practice makes permanent"
  
  static var allValues: [Proverb] = [.Fortune, .Late, .Practice]
  
  // Initializers
  init?(index: Int? = nil) {
    let i = index ?? Int(arc4random_uniform(UInt32(Proverb.allValues.count)))
    
    if i < Proverb.allValues.count {
      self = Proverb.allValues[i]
    } else {
      return nil
    }
  }
  
  // Instance methods
  func po(uppercase uppercase: Bool = false) {
    print(uppercase ? rawValue.uppercaseString : rawValue)
  }
  
}

let noProverb = Proverb(index: 10)

let proverb = Proverb(index: 1)!
proverb.po(uppercase: true)

enum CardSuit: String {
  
  case Spade = "♠️"
  case Heart = "♥️"
  case Diamond = "♦️"
  case Club = "♣️"
  
}

let cardStraight: [[CardSuit: String]] = [
  [.Spade: "Ace"],
  [.Heart: "King"],
  [.Diamond: "Queen"],
  [.Club: "Jack"],
  [.Spade: "Ten"]
]

for card in cardStraight {
  for (suit, value) in card {
    print("\(value) of \(suit.rawValue)s")
  }
}
