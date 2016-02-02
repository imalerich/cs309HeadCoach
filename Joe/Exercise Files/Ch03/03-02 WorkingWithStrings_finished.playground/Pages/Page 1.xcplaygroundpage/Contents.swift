//: ## Working With Strings

import Foundation

//: ### Defining

let quote = "In the end, we only regret the chances we didn't take."

var newQuote = quote

newQuote = "In the end, it doesn't even matter. -- Linkin Park"

print(quote)

let shape = "circle"
let radius = 5.0
let area = M_PI * radius * radius

print("The area of a \(shape) with a radius of \(radius) is \(area).")

print(String(format: "The area of a %@ with a radius of %.0f is %.2f.", shape, radius, area))

//: [Next](@next)
