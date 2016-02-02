//: ## Optional Binding

var firstName: String? = "Betty"

if let firstName = firstName {
  print("Hello, \(firstName)")
} else {
  print("Welcome, guest!")
}

var lastName: String? = "Gardner"

if let firstName = firstName, lastName = lastName {
  print("Hello, my name is\n\(firstName) \(lastName)")
} else {
  print("Hello, I am a guest")
}

if var firstName = firstName, let lastName = lastName {
  firstName = firstName.uppercaseString
//  lastName = lastName.uppercaseString
  print("Hello, my name is\n\(firstName) \(lastName)")
} else {
  print("Hello, I am a guest")
}
