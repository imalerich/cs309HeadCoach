//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using If & If-Else

import Foundation

let testScore = arc4random_uniform(50) + 50

if testScore >= 70 {
  print("You passed!")
} else {
  print("Study more and try again")
}

print("Your grade: ", terminator: "")

if testScore >= 70 {
  if testScore < 76 {
    print("C")
  } else if testScore < 80 {
    print("C+")
  } else if testScore < 86 {
    print("B")
  } else if testScore < 90 {
    print("B+")
  } else if testScore < 96 {
    print("A")
  } else {
    print("A+")
  }
} else {
  print("Study more and try again")
}

if #available(iOS 9, OSX 10.11, watchOS 2.0, *) {
  // Use applicable API from iOS 9, OS X 10.11, and watchOS 2.0
} else {
  // Use earlier API
}

//: [Next](@next)
