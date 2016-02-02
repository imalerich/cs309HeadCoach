//: ## Returning Tuples

import Foundation

let values = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
let suits = ["♠️", "♥️", "♦️", "♣️"]

func randomIndexForArrayCount(count: Int) -> Int {
  return Int(arc4random_uniform(UInt32(count)))
}


