//: [Previous](@previous)

//: ### Modifying

var quote = "In the end, we only regret the chances we didn't take."

let period = quote.removeAtIndex(quote.endIndex.predecessor())

print(quote)

let aRange = 0..<3

let startIndex = quote.endIndex.advancedBy(-41)
let endIndex = quote.endIndex
let range = startIndex..<endIndex

let replacementString = "it's not the years in your life that count. It's the life in your years. -- Abraham Lincoln"

quote.replaceRange(range, with: replacementString)

//: [Next](@next)
