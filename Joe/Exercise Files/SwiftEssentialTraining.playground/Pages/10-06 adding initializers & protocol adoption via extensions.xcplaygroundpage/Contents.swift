//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Adding Initializers & Protocol Adoption Via Extensions

struct Person {
  
  let firstName: String
  let middleName: String
  let lastName: String
  
}

extension Person {
  
  var fullName: String {
    return firstName.appendStrings(middleName, lastName)
  }
  
  init?(fullName: String) {
    let names = fullName.characters.split(" ").map(String.init)
    
    guard names.count == 3 else { return nil }
    
    self.init(firstName: names[0], middleName: names[1], lastName: names[2])
  }
  
}

let alfred = Person(firstName: "Alfred", middleName: "E.", lastName: "Neuman")

alfred.fullName

if let scott = Person(fullName: "Scott E. Gardner") {
  scott.firstName
  scott.middleName
  scott.lastName
}

extension Person: CustomStringConvertible {
  
  var description: String {
    return "Name: \(fullName)"
  }
  
}

print(alfred)

//: [Next](@next)
