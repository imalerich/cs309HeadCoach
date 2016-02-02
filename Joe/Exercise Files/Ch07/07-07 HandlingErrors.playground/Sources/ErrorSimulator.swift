import Foundation

/// Randomly returns `true` or `false` to simulate if an error occurred
public func simulatedErrorDidOccur() -> Bool {
  return arc4random_uniform(2) == 1
}
