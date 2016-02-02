//: [Previous](@previous)

//: ### For-In

for i in 0..<10 {
  print(i)
}

for var i in 1...3 {
  i *= 2
}

for i in (1...3).reverse() {
  print(i)
}

for _ in 0..<3 {
  print("I will not waste chalk")
}

for i in 3.stride(to: 30, by: 3) {
  print(i)
}

for i in 10.stride(through: 1, by: -1) {
  print(i, terminator: " ")
}
print("Lift off!")

let people = ["man": "👦", "woman": "👩", "girl": "👧", "boy": "👦"]

for (k, v) in people {
  print("\(k): \(v)")
}

let letters: Set = ["a", "b", "c"]

for v in letters {
  print(v)
}

for (i, c) in "SWIFT".characters.enumerate() {
  for j in 0..<i {
    print("\t", terminator: "")
  }
  
  print("\(c)\n", terminator: "")
}

let phrases = ["A couple", "A few or some", "Several or many"]

for t in phrases.enumerate() {
  print("For \(t.0 + 2) you can say, \"\(t.1).\"")
}

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

for n in numbers where n.isPrime {
  print("\(n) is a prime number")
}

