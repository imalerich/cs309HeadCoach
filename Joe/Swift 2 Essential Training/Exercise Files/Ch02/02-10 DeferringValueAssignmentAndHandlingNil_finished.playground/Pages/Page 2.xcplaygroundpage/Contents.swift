//: [Previous](@previous)

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

