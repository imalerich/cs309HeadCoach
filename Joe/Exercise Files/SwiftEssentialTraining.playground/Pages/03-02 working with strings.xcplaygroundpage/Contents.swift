//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Working with Strings

import Foundation

//: ### Defining

var quote = "In the end, we only regret the chances we didn't take."

var newQuote = quote

newQuote = "In the end, it doesn't even matter. -- Linkin Park"

print(quote)

let shape = "circle"
let radius = 5.0
let area = M_PI * radius * radius

print("The area of a \(shape) with a radius of \(radius) is \(area).")

print(String(format: "The area of a %@ with a radius of %.0f is %.2f.", shape, radius, area))

//: ### Inspecting

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

//: ### Modifying

let period = quote.removeAtIndex(quote.endIndex.predecessor())

print(quote)

let aRange = 0..<3

let startIndex = quote.endIndex.advancedBy(-41)
let endIndex = quote.endIndex
let range = startIndex..<endIndex

let replacementString = "it's not the years in your life that count. It's the life in your years. -- Abraham Lincoln"

quote.replaceRange(range, with: replacementString)

/*:
### Escape characters
* `\n` - new line (`\r` works, too)
* `\t` - tab
* `\` - escape `\` and `"`
* `\0` - null character
*/

print("\"Whatever you are, be a good one.\"\n\t\t\t-- Abraham Lincoln")

print("\0".isEmpty)

//: [Next](@next)
