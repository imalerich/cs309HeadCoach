//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Deferring Value Assignment & Handling `nil`

//: ### Deferring Value Assignment

var aphorism: String
aphorism = "Do or do not. There is no try."

var one, two, three: Int
one = 1
two = 2
three = 3

let constantString: String

constantString = "Don't wish. Do."

//: ### Optionals

var maybeAString: String?

print(maybeAString)

maybeAString = ""

maybeAString?.isEmpty
maybeAString == nil

maybeAString = "I am a string!"

print(maybeAString!)

var mostLikelyAnInt: Int!
mostLikelyAnInt = 8
print(mostLikelyAnInt)

let definitelyAString = maybeAString!

//: [Next](@next)
