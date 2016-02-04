extension String {
  
  /**
  Checks if string is a palindrome, ignoring spaces and capitalization.
  - author: Scott Gardner
  - seealso:
  * [Source on GitHub](http://bit.ly/SwiftStringPalindromeExtension)
  * [What's a palindrome?](https://en.wikipedia.org/wiki/Palindrome)
  - returns: Bool
  */
  public func isPalindrome() -> Bool {
    let s = String(self.characters.filter { $0 != Character(" ") }).lowercaseString
    return s == String(s.characters.reverse())
  }
  
}