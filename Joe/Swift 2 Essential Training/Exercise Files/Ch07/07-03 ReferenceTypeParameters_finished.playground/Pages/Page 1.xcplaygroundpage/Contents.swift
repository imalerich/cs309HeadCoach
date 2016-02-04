//: ## Reference Type Parameters

let person = Person(firstName: "Bob")

person.firstName = "Fred"

func reverseFirstNameOfPerson(person: Person) {
  let reversed = String(person.firstName.characters.reverse())
  person.firstName = reversed.capitalizedString
}

reverseFirstNameOfPerson(person)
person.firstName
//: [Next](@next)
