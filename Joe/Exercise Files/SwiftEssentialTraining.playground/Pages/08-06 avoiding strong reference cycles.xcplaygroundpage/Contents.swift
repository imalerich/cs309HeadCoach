//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Avoiding Strong Reference Cycles

//: ### Classes

class Teacher {
  
  var students = [Student]()
  
  deinit {
    print("Teacher will be deallocated")
  }
  
}

class Student {
  
  unowned let teacher: Teacher
  
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

mrsDonovan = nil
charlieBrown = nil

var teacher2: Teacher? = Teacher()
teacher2 = nil

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
  
  weak var band: Band?
  
  deinit {
    print("Drummer will be deallocated")
  }
  
}

var neilPeart: Drummer? = Drummer()

var rush: Band? = Band(drummer: neilPeart!)

neilPeart?.band = rush

neilPeart = nil
rush = nil

//: ### Closures

class Alpha {
  
  deinit {
    print("Alpha will be deallocated")
  }
  
}

class Bravo {
  
  let alpha = Alpha()
  
  lazy var printOutValues: () -> () = {
    [unowned self] in
    print("\(self), \(self.alpha)")
  }
  
  lazy var printOutAlphaValue: () -> () = {
    [weak alpha = self.alpha] in
    print("\(alpha)")
  }
  
  deinit {
    print("Bravo will be deallocated")
  }
  
}

var bravo: Bravo? = Bravo()

bravo?.printOutValues()
bravo?.printOutAlphaValue
bravo = nil

//: [Next](@next)
