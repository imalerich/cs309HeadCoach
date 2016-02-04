//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Modifying Arrays

var turnstileCounts = Array(count: 20, repeatedValue: 0)

var threeStooges = ["Moe", "Larry", "Curly"]

turnstileCounts[2] = 5

turnstileCounts[0] += 10

var fourStooges = threeStooges

fourStooges.append("Shemp")

let shemp = fourStooges.removeLast()

fourStooges.insert(shemp, atIndex: 0)

var allStooges = fourStooges + ["Ted", "Emil"]

allStooges += ["Joe Besser", "Joe DeRita"]

print(allStooges)

allStooges.removeRange(4...5)

allStooges.sortInPlace()

print(allStooges)

//: [Next](@next)
