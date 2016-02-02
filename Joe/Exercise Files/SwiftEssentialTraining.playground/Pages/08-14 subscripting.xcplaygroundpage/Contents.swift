//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Subscripting

struct Matrix3D {
  
  let numberOfRows, numberOfColumns, numberOfLayers: Int
  var coordinates = [Coordinate3D: String]()
  
  init(numberOfRows: Int, numberOfColumns: Int, numberOfLayers: Int) {
    self.numberOfRows = numberOfRows
    self.numberOfColumns = numberOfColumns
    self.numberOfLayers = numberOfLayers
  }
  
  func isValidCoordinate3d(coordinate: Coordinate3D) -> Bool {
    let x = coordinate.x
    let y = coordinate.y
    let z = coordinate.z
    
    let xIsValid = x >= -numberOfColumns / 2 && x <= numberOfColumns / 2
    let yIsValid = y >= -numberOfLayers / 2 && y <= numberOfLayers / 2
    let zIsValid = z >= -numberOfRows / 2 && z <= numberOfRows / 2
    
    return xIsValid && yIsValid && zIsValid
  }
  
  subscript(x: Int, y: Int, z: Int) -> String? {
    get {
      let coordinate = Coordinate3D(x: x, y: y, z: z)
      
      guard isValidCoordinate3d(coordinate) else {
        return nil
      }
      
      return coordinates[coordinate]
    }
    
    set {
      let coordinate = Coordinate3D(x: x, y: y, z: z)
      
      guard isValidCoordinate3d(coordinate) else { return }
      
      coordinates[coordinate] = newValue
    }
  }
  
}

var matrix3d = Matrix3D(numberOfRows: 10, numberOfColumns: 10, numberOfLayers: 10)

let before = matrix3d[1, 2, 3]
matrix3d[1, 2, 3] = "Hello, world!"

let after = matrix3d[1, 2, 3]

//: [Next](@next)
