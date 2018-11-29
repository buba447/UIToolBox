//
//  UIView+Convience.swift
//  UIToolBox
//
//  Created by Brandon Withrow on 10/12/18.
//

import Foundation
import UIKit

public extension UIView {
  
  /// Initializes a view with a background color.
  public convenience init(backgroundColor: UIColor?) {
    self.init(frame: .zero)
    self.backgroundColor = backgroundColor
  }
  
  /// Getter/Setter for the layer's corner radius.
  public var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
}
