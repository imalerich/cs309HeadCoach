//: [Previous](@previous)

import Foundation

start: while true {
  let speed = arc4random_uniform(50) + 50
  
  switch speed {
  case 55:
    print("I CAN drive 55!")
    break start
  case _ where speed > 70:
    print("I can't drive \(speed)!")
    continue start
  default:
    break
  }
  
  if speed > 70 {
    print("You were going \(speed). Here's your ticket!")
  }
}
