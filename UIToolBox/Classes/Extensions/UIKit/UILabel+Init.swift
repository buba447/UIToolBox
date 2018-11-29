import Foundation
import UIKit

extension UILabel {
  
  /// Returns a new Label with font and text color set.
  public convenience init(font: UIFont, textColor: UIColor) {
    self.init(frame: .zero)
    self.font = font
    self.textColor = textColor
  }
  
}
