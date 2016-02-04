//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Combining Strings & Arrays

//: ### Strings

var hello = "Hello, "
let world = "world!"

  let greeting = hello + world
hello
world

hello += "viewer!"
hello

let name = "Jaime"
let season = "Fall"

print("Hello, \(name)!" + "\n" + "Are you enjoying the \(season)?")

//: ### Arrays

var apples = ["McIntosh", "Red Delicious"]
apples += ["Granny Smith"]

let oranges = ["Navel", "Valencia", "Moro"]

let mixApplesAndOranges = (apples + oranges).sort()
apples
oranges

//: [Next](@next)
