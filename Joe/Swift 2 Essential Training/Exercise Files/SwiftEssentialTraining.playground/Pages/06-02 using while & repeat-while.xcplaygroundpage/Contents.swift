//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using While & Repeat-While

//: ### While

import Foundation

while arc4random_uniform(6) + 1 != 1 && arc4random_uniform(6) + 1 != 1 {
  print(".", terminator: "")
}
print("Snake eyes!")

//: ### Repeat-While

repeat {
  print(".", terminator: "")
} while arc4random_uniform(6) + 1 != 1 && arc4random_uniform(6) + 1 != 1

print("Snake eyes!")

//: [Next](@next)
