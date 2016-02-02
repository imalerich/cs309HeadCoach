//: ## Working With Generic Types

import Foundation

class Thing {
  
  let title: String
  
  init(_ title: Int) {
    self.title = "Thing \(title)"
  }
  
}

let numbers = [1, 2, 3]

let strings = ["One", "Two", "Three"]

let things = [Thing(1), Thing(2), Thing(3)]


