//: [Previous](@previous)

//: ### Inspecting

let quote: String = "In the end, we only regret the chances we didn't take."

quote.hasPrefix("In the beginning")
quote.hasSuffix("Abraham Lincoln")

quote.uppercaseString
quote.lowercaseString

quote.endIndex
quote.characters.count

let string1 = "\u{61}\u{301}\u{20DD}"
let string2 = "\u{E1}\u{20DD}"

string1 == string2

string1.endIndex
string2.endIndex

string1.characters.count
string2.characters.count

let firstCharacter = quote[quote.startIndex]

let secondCharacter = quote[quote.startIndex.successor()]

let fourthCharacter = quote[quote.startIndex.successor().successor().successor()]

//let eighthCharacter = quote[7]
let eighthIndex = quote.startIndex.advancedBy(7)

let eighthCharacter = quote[eighthIndex]

let lastCharacter = quote[quote.endIndex.predecessor()]

//: [Next](@next)
