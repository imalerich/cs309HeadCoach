//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using If-Case & For-Case

enum Number {
  case Integer(Int)
  case FloatingPoint(Double)
  case Text(String)
}

let someNumber = Number.FloatingPoint(12.34)

switch someNumber {
case .FloatingPoint(let n):
  print(n)
default:
  break
}

if case .FloatingPoint(let number) = someNumber where number > 12.0 {
  print(number)
}

let someAges: [Number] = [.Integer(19), .FloatingPoint(20.99), .Text("Twenty-something")]

for age in someAges {
  switch age {
  case .Integer(let a):
    print(a)
  default:
    break
  }
}

for case .Integer(let age) in someAges where age < 21 {
  print(age)
}

let currentVolume: Int? = 9

// Optional binding
if let volume = currentVolume where volume < 16 {
  print("Turn it up!")
}

// Optional pattern matching
if case let volume? = currentVolume where volume < 16 {
  print("Turn it up!")
}

let optionalNumbers: [Number?] = [nil, .FloatingPoint(50.0), nil, .Integer(37), nil, .Integer(45)]

for case .Integer(let number)? in optionalNumbers where number < 40 {
  print(number)
}

//: [Next](@next)
