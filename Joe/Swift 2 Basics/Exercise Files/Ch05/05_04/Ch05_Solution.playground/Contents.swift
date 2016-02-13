
func testAgeAndName(age : Int, firstName : String, lastName : String) -> Bool {
    if (age >= 18) || (firstName.characters.count + lastName.characters.count > 12) {
        return true
    }
    return false
}

testAgeAndName(14, firstName: "Bob", lastName: "Jones")
testAgeAndName(17, firstName: "Samantha Brown", lastName: "Brown")
testAgeAndName(33, firstName: "Christopher", lastName: "Washington")