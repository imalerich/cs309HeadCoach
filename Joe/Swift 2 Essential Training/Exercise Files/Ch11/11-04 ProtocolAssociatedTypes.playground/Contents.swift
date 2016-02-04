//: ## Protocol Associated Types

protocol HasMiddleValue {
  
  func middle() -> [Any]
  
}

extension Array: HasMiddleValue {
  
  func middle() -> [Any] {
    guard count > 0 else {
      return [Any]()
    }
    
    let middleIndex = count / 2
    let middleArray: [Any]
    
    if count % 2 != 0 {
      middleArray = [self[middleIndex]]
    } else {
      middleArray = [self[middleIndex - 1], self[middleIndex]]
    }
    
    return middleArray
  }
  
}

let doubles = [1.1, 2, 3.3, 4, 5.5, 6]



struct Person {
  
  var name = ""
  
}

let rush = [Person(name: "Neil"), Person(name: "Geddy"), Person(name: "Alex")]


