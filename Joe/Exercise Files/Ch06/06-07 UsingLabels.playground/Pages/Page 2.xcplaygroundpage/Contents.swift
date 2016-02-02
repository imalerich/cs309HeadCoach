//: [Previous](@previous)

import Foundation

while false {
  let speed = arc4random_uniform(50) + 50
  
  switch speed {
  case 55:
    print("I CAN drive 55!")
  case _ where speed > 70:
    print("I can't drive \(speed)!")
  default:
    break
  }
  
  if speed > 70 {
    print("You were going \(speed). Here's your ticket!")
  }
}
