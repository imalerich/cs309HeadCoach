//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Reference Type Parameters

let person = Person(firstName: "Bob")

person.firstName = "Fred"

func reverseFirstNameOfPerson(person: Person) {
  let reversed = String(person.firstName.characters.reverse())
  person.firstName = reversed.capitalizedString
}

reverseFirstNameOfPerson(person)
person.firstName

//: ### Function Parameters

func addTwoIntegers(a: Int, _ b: Int) -> Int {
  return a + b
}

func performIntegerOperation(operation: (Int, Int) -> Int, a: Int, b: Int) -> Int {
  return operation(a, b)
}

performIntegerOperation(addTwoIntegers, a: 10, b: 8)

//: [Next](@next)
