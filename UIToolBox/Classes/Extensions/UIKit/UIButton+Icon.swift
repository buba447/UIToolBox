//
//  UIButton+Icon.swift
//  FourEyes
//
//  Created by Brandon Withrow on 8/10/18.
//  Copyright © 2018 Brandon Withrow. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  
  /// Returns a button with the given icon tinted to the given color.
  public convenience init(icon: UIImage, color: UIColor) {
    self.init(type: .system)
    setImage(icon.withRenderingMode(.alwaysTemplate), for: .normal)
    tintColor = color
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
    heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
  }
  
  /// Returns a new button with target and action
  public convenience init(target: Any?, action: Selector) {
    self.init(frame: .zero)
    addTarget(target, action: action, for: .touchUpInside)
  }
}
