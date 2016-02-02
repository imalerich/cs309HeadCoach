public func ==(lhs: Coordinate3D, rhs: Coordinate3D) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

/// Stores x, y, and z integer values
public struct Coordinate3D: Hashable {
  
  public let x, y, z: Int
  
  public var hashValue: Int {
    return x | y | z
  }
  
  public init(x: Int, y: Int, z: Int) {
    self.x = x
    self.y = y
    self.z = z
  }
  
}
