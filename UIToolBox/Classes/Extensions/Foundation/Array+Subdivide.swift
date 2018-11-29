import Foundation

public extension Array {
  
  /// Returns an array that contains the elements of the recieving arrary nested in child arrays by stride.
  public func arrayBySubdividing(by: Int) -> Array<Array> {
    var returnArray: Array<Array> = []
    for i in stride(from: 0, to: count, by: by) {
      var rowContents: Array<Element> = []
      for r in 0...by {
        let x = i + r
        if x < count {
          rowContents.append(self[x])
        }
      }
      returnArray.append(rowContents)
    }
    return returnArray
  }
  
  /// Returns an array by shifting the elements of the recieving array by distance.
  public func shift(withDistance distance: Int = 1) -> Array<Element> {
    let offsetIndex = distance >= 0 ?
      self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
      self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
    
    guard let index = offsetIndex else { return self }
    return Array(self[index ..< endIndex] + self[startIndex ..< index])
  }
  
  /// Shifts the array in place by distance.
  public mutating func shiftInPlace(withDistance distance: Int = 1) {
    self = shift(withDistance: distance)
  }
  
}
