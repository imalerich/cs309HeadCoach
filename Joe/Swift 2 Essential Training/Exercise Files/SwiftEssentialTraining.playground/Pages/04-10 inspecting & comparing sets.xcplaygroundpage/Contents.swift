//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Inspecting & Comparing Sets

var teachers = Set<String>()

var students: Set = ["Charlotte", "Laura", "Kayleigh", "Kayla", "Boz", "Jake"]

students.count

teachers.isEmpty

var arrayOfStudents = Array(students)
arrayOfStudents.sortInPlace()

students.contains("Charlotte")

var schoolBusStudents: Set = ["Kayleigh", "Kayla", "Boz"]

schoolBusStudents.isSubsetOf(students)

schoolBusStudents.isStrictSubsetOf(students)

students.isSupersetOf(schoolBusStudents)

students.isStrictSupersetOf(schoolBusStudents)

schoolBusStudents.isDisjointWith(students)

//: [Next](@next)
