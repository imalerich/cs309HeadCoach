//: ## Working With `OptionSetType`

//enum Option: Int {
//  
//  case A = 1
//  case B = 2
//  case C = 4
//  
//}
//
//let allOptions = Option.A.rawValue | Option.B.rawValue | Option.C.rawValue

struct Option: OptionSetType {
  
  let rawValue: Int
  
  init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  static let A = Option(rawValue: 1 << 0)
  static let B = Option(rawValue: 1 << 1)
  static let C = Option(rawValue: 1 << 2)
  
  static let AAndC = [A, C]
  static let All = [A, B, C]
  
}

let allOptions: Option = [.A, .B, .C]

print(allOptions)

let all = Option.All

for option in all {
  print(option)
}
