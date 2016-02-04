//: [Previous](@previous)

//: ### Function Parameters

func addTwoIntegers(a: Int, _ b: Int) -> Int {
  return a + b
}

func performIntegerOperation(operation: (Int, Int) -> Int, a: Int, b: Int) -> Int {
  return operation(a, b)
}

performIntegerOperation(addTwoIntegers, a: 10, b: 8)

