//: ## Creating ErrorType Structures

import Foundation

func simulateHttpGet() throws {
  let httpStatusCode = (arc4random_uniform(5) + 1) * 100
  
  switch httpStatusCode {
  case 100:
    print("Continue")
  case 200:
    print("Success!")
  case 300:
    print("Redirection")
  case 400:
    print("Bad request")
  case 500:
    print("Internal server error")
  default:
    break
  }
  
}


