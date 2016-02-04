//: ## Defining & Calling Functions

func sayHelloWorld() {
  print("Hello, world!")
}

func sayHelloTo(name: String) {
  print("Hello, \(name)!")
}

func sayGreeting(greeting: String? = nil, toName name: String = "friend") {
  let theGreeting = greeting ?? "Hello"
  print("\(theGreeting), \(name)!")
}

sayGreeting("Good day", toName: "viewer")
sayGreeting("Hey")
sayGreeting(nil)
sayGreeting()

func addTwoIntegers(a: Int, _ b: Int) -> Int {
  return a + b
}

let sumOfIntegers = addTwoIntegers(3, 5)

let integerAdder: (Int, Int) -> Int = addTwoIntegers

integerAdder(4, 6)

let helloWorldSayer: () -> () = sayHelloWorld
let helloWorldSayer2: Void -> Void = sayHelloWorld

print("This", "is", "cool", separator: " ", terminator: "!")

func addDoubles(doubles: Double...) -> Double {
  return doubles.reduce(0, combine: +)
}

addDoubles(1.2, 3.4, 5.6)
