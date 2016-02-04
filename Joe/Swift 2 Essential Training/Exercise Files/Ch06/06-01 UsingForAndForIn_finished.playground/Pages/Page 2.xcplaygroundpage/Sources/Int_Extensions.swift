extension Int {
  
  /**
  `true` if self is a prime number, i.e., can only be divided evenly by 1 and itself.
  - author: Scott Gardner
  - seealso:
  * [Source on GitHub](http://bit.ly/SwiftIsPrimeIntExtension)
  */
  public var isPrime: Bool {
    guard self > 1 else {
      return false
    }
    
    for i in 2..<self {
      if self % i == 0 {
        return false
      }
    }
    
    return true
  }
    
}