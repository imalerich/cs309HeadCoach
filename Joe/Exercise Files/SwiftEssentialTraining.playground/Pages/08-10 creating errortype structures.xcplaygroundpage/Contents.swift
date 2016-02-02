//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Creating ErrorType Structures

import Foundation

struct HttpError: ErrorType {
  let code: Int
  let message: String
}

func simulateHttpGet() throws {
  let httpStatusCode = (arc4random_uniform(5) + 1) * 100
  var error: HttpError?
  
  switch httpStatusCode {
  case 100:
    print("Continue")
  case 200:
    print("Success!")
  case 300:
    print("Redirection")
  case 400:
    error = HttpError(code: 400, message: "Bad request")
  case 500:
    error = HttpError(code: 500, message: "Internal server error")
  default:
    break
  }
  
  if let error = error {
    throw error
  }
}

do {
  try simulateHttpGet()
} catch let error as HttpError {
  print("\(error.message) (\(error.code))")
}

//: [Next](@next)
