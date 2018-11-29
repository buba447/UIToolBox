//
//  MathKit.swift
//  UIToolBox
//
//  Created by Brandon Withrow on 10/10/18.
//

import Foundation
import UIKit

extension CGFloat {
  /**
   Interpolates the reciever to the given number by Amount.
   - Parameter toNumber: The number to interpolate to.
   - Parameter amount: The amount to interpolate from 0-1
   
   ```
   let number = 5
   let interpolated = number.interpolate(10, amount: 0.5)
   print(interpolated)
   // Result: 7.5
   ```
   
   1. The amount can be greater than one and less than zero. The interpolation will not be clipped.
   */
  public func interpolate(_ toNumber: CGFloat, amount: CGFloat) -> CGFloat {
    return self + ((self - toNumber) * amount)
  }
  
  /**
   Returns a value that is clamped between the two numbers
   
   1. The order of arguments does not matter.
  */
  public func clamp(_ a: CGFloat, _ b: CGFloat) -> CGFloat {
    return CGFloat(Double(self).clamp(Double(a), Double(b)))
  }
  
  /**
   Returns the difference between the reciever and the given number.
   - Parameter absolute: If *true* (Default) the returned value will always be positive.
   */
  public func diff(_ a: CGFloat, absolute: Bool = true) -> CGFloat {
    return absolute ? abs(a - self) : a - self
  }
  
  public func toRadians() -> CGFloat { return self * .pi / 180 }
  public func toDegrees() -> CGFloat { return self * 180 / .pi }
  
}

extension Double {
  
  /**
   Interpolates the reciever to the given number by Amount.
   - Parameter toNumber: The number to interpolate to.
   - Parameter amount: The amount to interpolate from 0-1
   
   ```
   let number = 5
   let interpolated = number.interpolate(10, amount: 0.5)
   print(interpolated)
   // Result: 7.5
   ```
   
   1. The amount can be greater than one and less than zero. The interpolation will not be clipped.
   */
  public func interpolate(_ toNumber: Double, amount: Double) -> Double {
    return self + ((self - toNumber) * amount)
  }
  
  /**
   Returns a value that is clamped between the two numbers
   
   1. The order of arguments does not matter.
   */
  public func clamp(_ a: Double, _ b: Double) -> Double {
    let minValue = a <= b ? a : b
    let maxValue = a <= b ? b : a
    return max(min(self, maxValue), minValue)
  }
  
}

extension CGRect {
  
  /// Initializes a new CGRect with a center point and size.
  public init(center: CGPoint, size: CGSize) {
    self.init(x: center.x - (size.width * 0.5),
              y: center.y - (size.height * 0.5),
              width: size.width,
              height: size.height)
  }
  
  /// Returns the total area of the rect.
  public var area: CGFloat {
    return width * height
  }
  
  
  /// The center point of the rect. Settable.
  public var center: CGPoint {
    get {
      return CGPoint(x: midX, y: midY)
    }
    set {
      origin = CGPoint(x: newValue.x - (size.width * 0.5),
                       y: newValue.y - (size.height * 0.5))
    }
  }
  
  /// The top left point of the rect. Settable.
  public var topLeft: CGPoint {
    get {
      return CGPoint(x: minX, y: minY)
    }
    set {
      origin = CGPoint(x: newValue.x,
                       y: newValue.y)
    }
  }
  
  /// The bottom left point of the rect. Settable.
  public var bottomLeft: CGPoint {
    get {
      return CGPoint(x: minX, y: maxY)
    }
    set {
      origin = CGPoint(x: newValue.x,
                       y: newValue.y - size.height)
    }
  }
  
  /// The top right point of the rect. Settable.
  public var topRight: CGPoint {
    get {
      return CGPoint(x: maxX, y: minY)
    }
    set {
      origin = CGPoint(x: newValue.x - size.width,
                       y: newValue.y)
    }
  }
  
  /// The bottom right point of the rect. Settable.
  public var bottomRight: CGPoint {
    get {
      return CGPoint(x: maxX, y: maxY)
    }
    set {
      origin = CGPoint(x: newValue.x - size.width,
                       y: newValue.y - size.height)
    }
  }
  
  /**
   Interpolates the reciever to the given rect by Amount.
   - Parameter to: The rect to interpolate to.
   - Parameter amount: The amount to interpolate from 0-1
   
   ```
   let rect = CGRect(x:0, y:0, width: 50, height: 50)
   let interpolated = rect.interpolate(CGRect(x:100, y:100, width: 100, height: 100), amount: 0.5)
   print(interpolated)
   // Result: (x: 50, y: 50, width: 75, height: 75)
   ```
   
   1. The amount can be greater than one and less than zero. The interpolation will not be clipped.
   */
  public func interpolate(_ to: CGRect, amount: CGFloat) -> CGRect {
    return CGRect(x: origin.x.interpolate(to.origin.x, amount: amount),
                  y: origin.y.interpolate(to.origin.y, amount: amount),
                  width: width.interpolate(to.width, amount: amount),
                  height: height.interpolate(to.height, amount: amount))
  }
  
}

extension CGSize {
  
  /**
   Interpolates the reciever to the given size by Amount.
   - Parameter to: The size to interpolate to.
   - Parameter amount: The amount to interpolate from 0-1
   
   ```
   let size = CGSize(width: 50, height: 50)
   let interpolated = rect.interpolate(CGSize(width: 100, height: 100), amount: 0.5)
   print(interpolated)
   // Result: (width: 75, height: 75)
   ```
   
   1. The amount can be greater than one and less than zero. The interpolation will not be clipped.
   */
  public func interpolate(_ to: CGSize, amount: CGFloat) -> CGSize {
    return CGSize(width: width.interpolate(to.width, amount: amount),
                  height: height.interpolate(to.height, amount: amount))
  }
  
  /// Returns the scale float that will fit the recieve inside of the given size.
  public func scaleThatFits(_ size: CGSize) -> CGFloat {
    return CGFloat.minimum(width / size.width, height / size.height)
  }
  
  /// Adds reciever size to give size.
  public func add(_ size: CGSize) -> CGSize {
    return CGSize(width: width + size.width, height: height + size.height)
  }
  
  /// Subtracts given size from reciever size.
  public func subtract(_ size: CGSize) -> CGSize {
    return CGSize(width: width - size.width, height: height - size.height)
  }
  
  /// Multiplies reciever size by the given size.
  public func multiply(_ size: CGSize) -> CGSize {
    return CGSize(width: width * size.width, height: height * size.height)
  }
  
  /// Operator convenience to add sizes with +
  public static func +(left: CGSize, right: CGSize) -> CGSize {
    return left.add(right)
  }
  
  /// Operator convenience to subtract sizes with -
  public static func -(left: CGSize, right: CGSize) -> CGSize {
    return left.subtract(right)
  }
  
  /// Operator convenience to multiply sizes with *
  public static func *(left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
  }
  
}

/// A struct that defines a line segment with two CGPoints
public struct CGLine {
  
  /// The Start of the line segment.
  public var start: CGPoint
  /// The End of the line segment.
  public var end: CGPoint
  
  /// Initializes a line segment with start and end points
  public init(start: CGPoint, end: CGPoint) {
    self.start = start
    self.end = end
  }
  
  /// The lenght of the line segment.
  public var length: CGFloat {
    return end.distanceFrom(start)
  }
  
  /// Returns a line sgement that is normalized to a length of 1
  public func normalize() -> CGLine {
    let len = length
    guard len > 0  else {
      return self
    }
    let relativeEnd = end - start
    let relativeVector = CGPoint(x: relativeEnd.x / len, y: relativeEnd.y / len)
    let absoluteVector = relativeVector + start
    return CGLine(start: start, end: absoluteVector)
  }
  
  /// Trims a line segment to the given length
  public func trimmedToLength(_ tolength: CGFloat) -> CGLine {
    let len = length
    guard len > 0  else {
      return self
    }
    let relativeEnd = end - start
    let relativeVector = CGPoint(x: relativeEnd.x / len, y: relativeEnd.y / len)
    let sizedVector = CGPoint(x: relativeVector.x * tolength, y: relativeVector.y * tolength)
    let absoluteVector = sizedVector + start
    return CGLine(start: start, end: absoluteVector)
  }
  
  /// Flips a line vertically and horizontally from the start point.
  public func flipped() -> CGLine {
    let relativeEnd = end - start
    let flippedEnd = CGPoint(x: relativeEnd.x * -1, y: relativeEnd.y * -1)
    return CGLine(start: start, end: flippedEnd + start)
  }
  
  /// Move the line to the new start point.
  public func transpose(_ toPoint: CGPoint) -> CGLine {
    let diff = toPoint - start
    let newEnd = end + diff
    return CGLine(start: toPoint, end: newEnd)
  }
  
}

extension CGPoint {
  
  /// Returns the distance between the reciever and the given point.
  public func distanceFrom(_ a: CGPoint) -> CGFloat {
    let xDist = x - a.x
    let yDist = y - a.y
    return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
  }
  
  /// Returns the length between the reciever and *CGPoint.zero*
  public var vectorLength: CGFloat {
    return distanceFrom(.zero)
  }
  
  public func rounded(decimal: CGFloat) -> CGPoint {
    return CGPoint(x: (round(decimal * x) / decimal), y: (round(decimal * y) / decimal))
  }
  
  /**
   Interpolates the reciever to the given Point by Amount.
   - Parameter to: The Point to interpolate to.
   - Parameter amount: The amount to interpolate from 0-1
   
   ```
   let point = CGPoint(width: 50, height: 50)
   let interpolated = rect.interpolate(CGPoint(width: 100, height: 100), amount: 0.5)
   print(interpolated)
   // Result: (x: 75, y: 75)
   ```
   
   1. The amount can be greater than one and less than zero. The interpolation will not be clipped.
   */
  public func interpolate(_ to: CGPoint, amount: CGFloat) -> CGPoint {
    return CGPoint(x: x.interpolate(to.x, amount: amount),
                   y: y.interpolate(to.y, amount: amount))
  }
  
  /// Subtracts the given point from the receiving point.
  public func subtract(_ point: CGPoint) -> CGPoint {
    return CGPoint(x: x - point.x,
                   y: y - point.y)
  }
  
  /// Adds the given point from the receiving point.
  public func add(_ point: CGPoint) -> CGPoint {
    return CGPoint(x: x + point.x,
                   y: y + point.y)
  }
  
  /// Operator convenience to divide points with /
  public static func / (lhs: CGPoint, rhs: Float) -> CGPoint {
    return CGPoint(x: lhs.x / CGFloat(rhs), y: lhs.y / CGFloat(rhs))
  }
  
  /// Operator convenience to multiply points with *
  public static func * (lhs: CGPoint, rhs: Float) -> CGPoint {
    return CGPoint(x: lhs.x * CGFloat(rhs), y: lhs.y * CGFloat(rhs))
  }
  
  /// Operator convenience to add points with +
  public static func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return left.add(right)
  }
  
  /// Operator convenience to subtract points with -
  public static func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return left.subtract(right)
  }
}
