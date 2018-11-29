import UIKit

public extension UIStackView {
  
  /// Removes all arranged subviews from the stackview.
  public func removeAllArrangedSubviews() {
    let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
      self.removeArrangedSubview(subview)
      return allSubviews + [subview]
    }
    // Remove the views from self
    removedSubviews.forEach({ $0.removeFromSuperview() })
  }
  
}
