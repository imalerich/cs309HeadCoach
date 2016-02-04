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
  
}
