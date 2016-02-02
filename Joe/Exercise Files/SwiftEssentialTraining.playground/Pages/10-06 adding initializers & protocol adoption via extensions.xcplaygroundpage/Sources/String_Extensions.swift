extension String {
  
  public func appendStrings(strings: String..., withPadding padding: String = " ") -> String {
    let stringsArray = [self] + strings
    return stringsArray.joinWithSeparator(padding)
  }
  
}
