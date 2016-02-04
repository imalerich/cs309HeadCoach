//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Associating Values in Enumerations

class Person {
  
  let lastName: String
  
  init(lastName: String) {
    self.lastName = lastName
  }
  
}

enum Marine {
  
  case Master_Gunnery_Sergeant(Person)
  case Sergeant_Major(Person)
  case Sergeant_Major_Of_The_Marine_Corps(Person)
  
}

let porterfield = Person(lastName: "Porterfield")

let marineSergeantMajor = Marine.Sergeant_Major(porterfield)

func printMarine(marine: Marine) {
  let person: Person
  
  switch marine {
  case .Master_Gunnery_Sergeant(let p):
    person = p
  case .Sergeant_Major(let p):
    person = p
  case .Sergeant_Major_Of_The_Marine_Corps(let p):
    person = p
  }
  
  func printRankLastNameForPerson(person: Person) {
    let rankAsString = String(marine)
    let rankCharacters = rankAsString.characters
    let indexOfParenthesis = rankCharacters.indexOf("(")!
    let rankRoot = rankAsString[rankAsString.startIndex..<indexOfParenthesis]
    
    let rankString = rankRoot
      .characters.split("_")
      .map(String.init)
      .joinWithSeparator(" ")
    
    print(rankString, person.lastName)
  }
  
  printRankLastNameForPerson(person)
}

print(marineSergeantMajor)

printMarine(marineSergeantMajor)

var maybeAnInt: Optional<Int>

maybeAnInt = 1

maybeAnInt = nil

maybeAnInt = .Some(2)

maybeAnInt = .None

//: [Next](@next)
