//: ## Overloading Functions

func processInput(input: String) { }

func processInput(input: Int) { }

//func processInput(int: Int) { }

func processInput(input: Int) -> String {
  return "\(input)."
}

func processInput(input: Int) -> Int {
  return input * input
}

let a = 1 + 2

let b = 3

a ~= b

func ~=(integer: Int, string: String) -> Bool {
  return "\(integer)" == string
}

let c = "3"

a ~= c
