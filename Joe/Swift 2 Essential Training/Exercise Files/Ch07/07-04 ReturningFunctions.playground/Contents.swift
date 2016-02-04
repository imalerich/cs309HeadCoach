//: ## Returning Functions

func sayHelloWorld() {
  print("Hello, world")
}



func addDoubles(doubles: Double...) -> Double {
  return doubles.reduce(0, combine: +)
}


