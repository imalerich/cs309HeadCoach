//: ## Extending Concrete Types

let quickBrownFox: String = "The quick brown fox jumped over the lazy dog"

quickBrownFox.characters.count

quickBrownFox.length

extension String {
  
  var length: Int {
    return characters.count
  }
  
}

extension Optional {
  
  var hasValue: Bool {
    switch self {
    case .None:
      return false
    case .Some(_):
      return true
    }
  }
  
}

var string: String? = "Extensions are cool!"
string.hasValue

var integer: Int?
integer.hasValue

extension String {
  
  func appendStrings(strings: String..., withPadding padding: String = " ") -> String {
    let stringsArray = [self] + strings
    return stringsArray.joinWithSeparator(padding)
  }
  
}

"a".appendStrings("b", "c", "d", withPadding: " - ")

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
