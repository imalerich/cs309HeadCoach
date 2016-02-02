//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Working with Closures

import Foundation

var names = ["Scott", "Lori", "Charlotte", "Betty", "Gracie", "Sophie", "Stella", "Isabella", "Lilith", "Darby"]

let sNames = names.filter({ (name: String) -> Bool in
  return name.lowercaseString.characters.first! == "s"
})

let sNames2 = names.filter {
  $0.lowercaseString.characters.first! == "s"
}

let reversedSortedNames = names.sort(>)
reversedSortedNames

let randomName: String = {
  let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
  return names[randomIndex]
}()

let helloSayer = { print("Hello, world!") }
helloSayer()

let randomNameGetter: () -> String = {
  let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
  return names[randomIndex]
}

randomNameGetter()

let phrase = "It doesn't matter in what order the letters of a word appear as long as the first and last characters are in the right place the rest can be a total mess and you can probably still read it"

let scrambleWord = { (string: String) -> String in
  guard string.characters.count > 3 else {
    return string
  }
  
  let characters = Array(string.characters)
  var middleCharacters = Array(characters[1..<characters.count - 1])
  let count = middleCharacters.count
  
  for i in 0..<count {
    let j = Int(arc4random_uniform(UInt32(count)))
    
    guard i != j else { continue }
    
    swap(&middleCharacters[i], &middleCharacters[j])
  }
  
  return "\(characters.first!)" + String(middleCharacters) + "\(characters.last!)"
}

phrase.characters.split { $0 == " " }
  .map { String($0) }
  .map { scrambleWord($0) }
  .forEach { print("\($0) ", terminator: "") }

print("")

phrase.characters.split(" ")
  .map(String.init)
  .map(scrambleWord)
  .forEach { print("\($0) ", terminator: "") }

//: [Next](@next)
