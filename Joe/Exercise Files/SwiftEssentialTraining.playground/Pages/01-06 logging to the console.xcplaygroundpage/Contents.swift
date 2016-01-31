//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Logging to the Console

import UIKit

var str = "Hello, playground"

var hello = "Hello,"; var playground = "playground"

print(str)

NSLog(str)

//println(str)

print(hello, playground)
print(hello, playground, separator: "_", terminator: "")
print("...")

print("\(hello) viewer!")

print("1 + 1 = \(1 + 1)")

//: ### Literal Expressions

func printLiteralExpressions() {
  
  print("Function: \(__FUNCTION__)")
  print("File: \(__FILE__)")
  print("Line: \(__LINE__)")
  print("Column: \(__COLUMN__)")
  
}

printLiteralExpressions()

//: [Next](@next)
