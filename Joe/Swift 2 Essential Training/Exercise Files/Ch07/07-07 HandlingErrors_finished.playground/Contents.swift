//: ## Handling Errors

import Foundation

let encounteredErrorA = simulatedErrorDidOccur()
let encounteredErrorB = simulatedErrorDidOccur()

enum Error: ErrorType {
  case A
  case B(code: UInt32, function: String, line: Int)
}

func performAction() throws {
  defer {
    let count = (encounteredErrorA ? 1 : 0) + (encounteredErrorB ? 1 : 0)
    print("Action completed with \(count) " + (count == 1 ? "error" : "errors"))
  }
  
  guard encounteredErrorA == false else {
    throw Error.A
  }
  
  guard encounteredErrorB == false else {
    let randomCode = arc4random_uniform(10)
    throw Error.B(code: randomCode, function: __FUNCTION__, line: __LINE__)
  }
  
  print("Action completed successfully!")
}

do {
  try performAction()
  print("No error occurred")
} catch Error.A {
  print("Error A encountered!")
} catch let Error.B(code, function, line) where code > 4 {
  print("Error B encountered in \(function) at line \(line) (code: \(code))")
} catch {
  print("Uh oh, something went wrong: \(error)")
}

func doSomething() {
  do {
    try performAction()
  } catch {
    print("Uh oh...")
  }
}

doSomething()

func doSomethingElse() throws {
  try performAction()
}

do {
  try doSomethingElse()
} catch {
  print("Uh oh...")
}

func performActionThatMightFail() throws -> String {
  return "Success!"
}

let success = try? performActionThatMightFail()

try! performActionThatMightFail()
