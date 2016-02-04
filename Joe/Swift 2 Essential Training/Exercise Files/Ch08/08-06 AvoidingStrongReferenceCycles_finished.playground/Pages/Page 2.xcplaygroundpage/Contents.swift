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

