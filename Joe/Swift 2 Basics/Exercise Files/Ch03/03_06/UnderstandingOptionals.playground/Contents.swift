//Optionals

//empty = nil

var a = 3
var b = a + 5

var c : Int?
c = 3
var d = c! + 5

if let nonOptionalValue = c {
    //perform operation
    var e = nonOptionalValue + 5
}

import Foundation

var optString : String?

optString = "First "

optString?.stringByAppendingString("more")
