//: ## Avoiding Strong Reference Cycles

//: ### Classes

class Teacher {
  
  var students = [Student]()
  
  deinit {
    print("Teacher will be deallocated")
  }
  
}

class Student {
  
  let teacher: Teacher
  
  init(teacher: Teacher) {
    self.teacher = teacher
  }
  
  deinit {
    print("Student will be deallocated")
  }
  
}

var mrsDonovan: Teacher? = Teacher()

var charlieBrown: Student? = Student(teacher: mrsDonovan!)

mrsDonovan?.students.append(charlieBrown!)



class Band {
  
  var drummer: Drummer
  
  init(drummer: Drummer) {
    self.drummer = drummer
  }
  
  deinit {
    print("Band will be deallocated")
  }
  
}

class Drummer {
  
  var band: Band?
  
  deinit {
    print("Drummer will be deallocated")
  }
  
}

var neilPeart: Drummer? = Drummer()

var rush: Band? = Band(drummer: neilPeart!)

neilPeart?.band = rush



//: [Next](@next)
