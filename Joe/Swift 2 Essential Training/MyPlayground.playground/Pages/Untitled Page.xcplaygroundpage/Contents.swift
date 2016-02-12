//: Playground - noun: a place where people can play

import UIKit


/*
var complexArray : [Any] = Array()

complexArray.append(5)
complexArray.append("A String")

complexArray.count
complexArray.removeAtIndex(0)



var dictionary1 = ["apple": "red", "banana": "yellow"]

var dictionary2 : [String: Int] = Dictionary()
dictionary2["Hello"] = 1

var dictionary3 : [String: Any] = Dictionary()

dictionary3["Goodbye"] = "A String"
dictionary3["Key"] = 0
*/


// practice with optionals

var a : Int?
a = 3
var b = a! + 5

// optional binding
if let nonOptionalValue = a {
    //perform operation
    var c = nonOptionalValue + 5
}


import Foundation

var optString : String?

optString = "First "

optString?.stringByAppendingString("more")


//: [Next](@next)
