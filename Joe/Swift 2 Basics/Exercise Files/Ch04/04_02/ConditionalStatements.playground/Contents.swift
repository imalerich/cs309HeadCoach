let myBool = false

if (myBool) {
    print("true")
} else {
    print("false")
}

let animal = "dog"

if (animal == "dog") {
    print("Canine")
} else if (animal == "cat") {
    print("Feline")
} else if (animal == "mouse") {
    print("Rodent")
} else {
    print("Unknown")
}

switch(animal) {
    case "dog":
    print("Canine")
    //fallthrough
    case "cat":
    print("Feline")
    case "mouse":
    print("Rodent")
    default:
    print("Unknown")
}

func printPositiveNumber(t : Int) {
    guard(t > 0) else {
        return
    }
    print(t)
}

printPositiveNumber(3)
printPositiveNumber(-1)


var c = 5
if (c < 10) {
    print("Less than")
}

