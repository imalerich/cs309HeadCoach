//: [Previous](@previous)

//: ### Closures

class Alpha {
  
  deinit {
    print("Alpha will be deallocated")
  }
  
}

class Bravo {
  
  let alpha = Alpha()
  
  lazy var printOutValues: () -> () = {
    print("\(self), \(self.alpha)")
  }
  
  lazy var printOutAlphaValue: () -> () = {
    print("\(self.alpha)")
  }
  
  deinit {
    print("Bravo will be deallocated")
  }
  
}

var bravo: Bravo? = Bravo()



