import Foundation

public extension Array {
  /// Returns a random element from self
  public func randomItem() -> Element {
    return self[Int(arc4random_uniform(UInt32(count)))]
  }
}
