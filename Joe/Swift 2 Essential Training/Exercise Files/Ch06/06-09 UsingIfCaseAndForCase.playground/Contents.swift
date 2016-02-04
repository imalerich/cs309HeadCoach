//: ## Using If-Case & For-Case

enum Number {
  case Integer(Int)
  case FloatingPoint(Double)
  case Text(String)
}

let someNumber = Number.FloatingPoint(12.34)

switch someNumber {
case .Integer(let n):
  break
case .FloatingPoint(let n):
  print(n)
case .Text(let n):
  break
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



let currentVolume: Int? = 9

// Optional binding
if let volume = currentVolume where volume < 16 {
  print("Turn it up!")
}



let optionalNumbers: [Number?] = [nil, .FloatingPoint(50.0), nil, .Integer(37), nil, .Integer(45)]


