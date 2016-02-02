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

class ItemHolder<T> {
  
  var items: [T]
  
  init(items: [T]) {
    self.items = items
  }
  
  func randomItem() -> T {
    let index = Int(arc4random_uniform(UInt32(items.count)))
    return items[index]
  }
  
}

let numbersHolder = ItemHolder(items: numbers)
let thingsHolder = ItemHolder(items: things)

numbersHolder.randomItem()
thingsHolder.randomItem().title

func randomItemFromArray<T>(items: [T]) -> T {
  let index = Int(arc4random_uniform(UInt32(items.count)))
  return items[index]
}

randomItemFromArray(["Alpha", "Bravo", "Charlie"])
