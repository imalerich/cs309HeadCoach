//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using Ternary Conditional & Nil Coalescing Operators

let name = "Charlotte"

let salutation = name.isEmpty ? "Hello!" : "Hi, \(name)!"

name.isEmpty ? print("No name given") : print("Name is \(name)")

let birthYear = 2005

let generation = birthYear < 1945 ? "Greatest Generation" :
  birthYear < 1965 ? "Baby Boomers" :
  birthYear < 1982 ? "Generation X" :
  birthYear < 1996 ? "Generation Y" :
"Generation Z"

let defaultSize = "M"

var selectedSize: String?

let orderSize = selectedSize ?? defaultSize

//: [Next](@next)
