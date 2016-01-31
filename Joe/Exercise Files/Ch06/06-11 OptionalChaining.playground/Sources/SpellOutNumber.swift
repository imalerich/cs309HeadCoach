import Foundation

/**
Converts any number (e.g., 1) or a number string (e.g., "1") into a spelled-out number string (e.g., "one").
- author: Scott Gardner
- seealso:
* [Source on GitHub](http://bit.ly/SwiftSpellOutNumber)
- parameter number: a number or number string
- returns: String?
*/
public func spellOutNumber<N>(number: N) -> String? {
  let formatter = NSNumberFormatter()
  formatter.numberStyle = .SpellOutStyle
  
  switch number {
  case is Int, is UInt, is Float, is Double:
    return formatter.stringFromNumber(number as! NSNumber)
  case is String:
    if let number = Double((number as! String)) {
      return formatter.stringFromNumber(number)
    }
  default:
    break
  }
  
  return nil
}