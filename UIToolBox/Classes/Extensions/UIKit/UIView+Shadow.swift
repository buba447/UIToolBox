import Foundation

/// A struct that wraps shadow styles.
public struct LayerShadow {
  public let shadowColor: UIColor
  public let shadowOpacity: Float
  public let shadowRadius: CGFloat
  public let shadowOffset: CGSize
  
  public init(shadowColor: UIColor,
              shadowOpacity: Float,
              shadowRadius: CGFloat,
              shadowOffset: CGSize) {
    self.shadowColor = shadowColor
    self.shadowOpacity = shadowOpacity
    self.shadowRadius = shadowRadius
    self.shadowOffset = shadowOffset
  }
}

public extension UIView {
  
  /// Sets a LayerShadow on a UIView
  public func setShadow(shadow: LayerShadow?) {
    guard let shadow = shadow else {
      layer.shadowColor = nil
      return
    }
    layer.shadowColor = shadow.shadowColor.cgColor
    layer.shadowOffset = shadow.shadowOffset
    layer.shadowRadius = shadow.shadowRadius
    layer.shadowOpacity = shadow.shadowOpacity
  }
}
