//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using Switch

let die1 = [1, 2, 3, 4, 5, 6].randomItem()
let die2 = [1, 2, 3, 4, 5, 6].randomItem()

switch (die1, die2) {
  
case (1, 1):
  fallthrough
case (6, 6):
  print("30 points")
case (1...2, 1...2):
  print("16 points")
case _ where die1 + die2 == 7:
  print("5 points")
case let (thrown, _) where die1 == die2:
  
  switch thrown * 2 {
  case 4, 10:
    print("8 points")
  default:
    print("10 point")
  }
  
default:
  break
  
}

//: [Next](@next)
