//: ## Returning Tuples

import Foundation

func dealACard() -> (value: String, suit: String) {
  let values = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  let suits = ["♠️", "♥️", "♦️", "♣️"]
  
  func randomIndexForArrayCount(count: Int) -> Int {
    return Int(arc4random_uniform(UInt32(count)))
  }
  
  let randomValueIndex = randomIndexForArrayCount(values.count)
  let randomSuitIndex = randomIndexForArrayCount(suits.count)
  return (values[randomValueIndex], suits[randomSuitIndex])
}

dealACard()
