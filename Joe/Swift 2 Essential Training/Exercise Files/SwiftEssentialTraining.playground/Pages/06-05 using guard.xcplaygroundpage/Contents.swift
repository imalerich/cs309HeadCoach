//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Using Guard

import Foundation

let twentyOnesBirthday = NSDate().dateByAddingTimeInterval(-31_536_000 * 21)

let peopleInLine = ["Joey": joeysBirthday, "Brenda": brendasBirthday, "Chris": chrisBirthday, "Oliver": oliversBirthday]

for (name, birthday) in peopleInLine {
  guard birthday.earlierDate(twentyOnesBirthday) == birthday else {
    print("\(name) is not old enough to enter the club")
    continue
  }
  
  print("\(name) can enter")
}

func updateSignForLifeguardOnDuty(lifeguardOnDuty: String?) {
  guard let lifeguardName = lifeguardOnDuty else {
    print("No lifeguard on duty. Swim at your own risk.")
    return
  }
  
  print("Lifeguard on duty: \(lifeguardName)")
}

updateSignForLifeguardOnDuty(nil)
updateSignForLifeguardOnDuty("C.J.")

//: [Next](@next)
