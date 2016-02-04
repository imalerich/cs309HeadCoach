/*:
## Creating Custom Operators
### .., /, =, -, +, !, *, %, <, >, &, |, ^, ?, or ~, or certain Unicode characters
[See documentation](http://bit.ly/swiftlexicalstructure)
*/

import UIKit

infix operator <==> { precedence 130 associativity left }

func <==>(left: CGPoint, right: CGPoint) -> Bool {
  return left.x == right.x && left.y == right.y
}

let pointA = CGPoint(x: 5, y: 5)

let pointB = CGPoint(x: 5, y: 10)

pointA <==> pointB
