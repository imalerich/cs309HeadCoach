//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Protocol Associated Types

protocol HasMiddleValue {
  
  typealias ItemType
  func middle() -> [ItemType]
  
}

extension Array: HasMiddleValue {
  
  typealias ItemType = Generator.Element
  
  func middle() -> [ItemType] {
    guard count > 0 else {
      return [ItemType]()
    }
    
    let middleIndex = count / 2
    let middleArray: [ItemType]
    
    if count % 2 != 0 {
      middleArray = [self[middleIndex]]
    } else {
      middleArray = [self[middleIndex - 1], self[middleIndex]]
    }
    
    return middleArray
  }
  
}

let doubles = [1.1, 2, 3.3, 4, 5.5, 6]

let middleValues = doubles.middle()

let sumOfMiddleValues = middleValues[0] + middleValues[1]

struct Person {
  
  var name = ""
  
}

let rush = [Person(name: "Neil"), Person(name: "Geddy"), Person(name: "Alex")]

let geddy = rush.middle()

geddy[0].name

//: [Next](@next)
