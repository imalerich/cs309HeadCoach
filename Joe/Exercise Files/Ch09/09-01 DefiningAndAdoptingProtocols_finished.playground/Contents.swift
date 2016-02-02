//: ## Protocols

//: ### Defining & Adopting

import Foundation

protocol DemonstratesProtocol {
  
  var propertyRequirement: String { get set }
  
  init?(x: Int, y: Int)
  
  func methodRequirement(input: String?) -> Int?
  
  subscript(x: Int, y: Int) -> Int { get set }
  
}

protocol SomeOtherProtocol {
  // Requirements
}

protocol DemonstratesProtocolInheritance: DemonstratesProtocol, SomeOtherProtocol {
  // Additional requirements
}

protocol HasTitle {
  
  var title: String { get }
  //  init(title: String)
  
}

protocol HasSubtitle: HasTitle {
  
  var subtitle: String? { get }
  
}

protocol HasAuthor {
  
  var author: Author { get }
  
}

protocol Ratable: class {
  
  var ratings: [Int] { get set }
  func addRating(rating: Int)
  func getAverageRating() -> Double
  
}

@objc protocol InstanceCountable {
  
  static var count: Int { get set }
  optional static func printInstanceCount()
  
}

class Author {
  
  let name: String
  
  init(name: String) {
    self.name = name
  }
  
}

class Book: HasSubtitle, HasAuthor, Ratable, InstanceCountable, CustomStringConvertible {
  
  @objc static var count = 0
  
  var title = ""
  let subtitle: String?
  let author: Author
  var ratings = [Int]()
  
  var description: String {
    let subtitleString = subtitle != nil ? "\n\(subtitle)\n" : ""
    return "\(title)\(subtitleString)\nBy: \(author.name)\nRating: \(getAverageRating())"
  }
  
  //  required init(title: String) {
  //    self.title = title
  //  }
  
  init(title: String, author: Author, subtitle: String? = nil) {
    self.title = title
    self.subtitle = subtitle
    self.author = author
    print("Book count: \(++Book.count)")
  }
  
  @objc static func printInstanceCount() {
    print("Book count: \(count)")
  }
  
  func addRating(rating: Int) {
    ratings.append(rating)
  }
  
  func getAverageRating() -> Double {
    return ratings.count == 0 ? 0.0 : Double(ratings.reduce(0) { $0 + $1 }) / Double(ratings.count)
  }
  
}

class SomeObject: NSObject, InstanceCountable {
  static var count = 0
}

let book = Book(title: "Reminiscences of a Stock Operator", author: Author(name: "Edwin Lefevre"))

book is HasTitle

book.addRating(4)
book.addRating(5)

print(book)

