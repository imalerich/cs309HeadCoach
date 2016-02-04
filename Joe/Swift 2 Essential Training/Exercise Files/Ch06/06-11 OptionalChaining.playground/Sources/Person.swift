import Foundation

public class Person {
  
  private lazy var dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    return formatter
    }()
  
  public var firstName: String
  public var lastName: String?
  
  public var name: String {
    return lastName != nil ? "\(firstName) \(lastName!)" : "\(firstName)"
  }
  
  public var age: Int? {
    if let birthday = _birthday {
      return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: birthday, toDate: NSDate(), options: []).year
    }
    return nil
  }
  
  public var birthday: String? {
    didSet {
      if let birthday = birthday {
        _birthday = dateFormatter.dateFromString(birthday)
      }
    }
  }
  
  private var _birthday: NSDate?
  public var father: Person?
  public var mother: Person?
  public var children: [Person]?
  
  public init(firstName: String, lastName: String? = nil) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
  public func spelledOutAge() -> String? {
    if let age = age {
      return spellOutNumber(age)
    }
    return nil
  }
  
}
