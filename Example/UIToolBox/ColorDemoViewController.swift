//
//  ViewController.swift
//  UIToolBox
//
//  Created by buba447 on 10/10/2018.
//  Copyright (c) 2018 buba447. All rights reserved.
//

import UIKit
import UIToolBox

class ColorDemoViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Create a color with Hue Saturation and Brightness
    let color = UIColor(hue: 0.5, saturation: 1, brightness: 1, alpha: 1)
    
    /// Set the view background color to be a dark complementary color.
    view.backgroundColor = color.complementary.withBrightness(brightness: 0.2)
    
    /// Create a view with the color
    let colorView = UIView(backgroundColor: color)
    colorView.cornerRadius = 12
    view.addSubview(colorView)
    
    
    
    /// Make a constraint group that pins the colorView to the top, leading and traling, with a height of 50
    let topConstraint = ConstraintGroup(constraints: [
      colorView.alignTopToView(view),
      colorView.constrainHeight(50),
      colorView.alignLeadingToView(view),
      colorView.alignTrailingToView(view)
      ])
    
    /// Make a constraint group that pins the colorView to the bottom, leading and trailing with a padding of 20, and a height of 72
    let bottomConstraint = ConstraintGroup(constraints: [
      colorView.alignBottomToView(view, constant: 30),
      colorView.constrainHeight(72),
      colorView.alignLeadingToView(view, constant: 20),
      colorView.alignTrailingToView(view, constant: 20)
      ])
    
    /// Set the top constraint to enabled, the bottom to disabled.
    topConstraint.enable()
    bottomConstraint.disable()
    view.layoutIfNeeded()
    
    
    self.topConstraint = topConstraint
    self.bottomConstraint = bottomConstraint
    
    self.colorView = colorView

  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    /// Now lets animate from one constraint group to another with a spring animation.
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.toggleAnimation()
    }

  }
  
  func toggleAnimation() {
    if (self.topConstraint?.isEnabled)! {
      self.topConstraint?.disable()
      self.bottomConstraint?.enable()
    } else {
      self.topConstraint?.enable()
      self.bottomConstraint?.disable()
    }
    
    self.view.animateLayoutChanges(
      style: .slowSpring,
      withAnimation: {
        /// Animate the background color to its complementary.
        self.colorView?.backgroundColor = self.colorView?.backgroundColor?.complementary
    }) { (complete) in
      /// Animation complete!
      self.toggleAnimation()
    }
  }
  
  
  var topConstraint: ConstraintGroup?
  var bottomConstraint: ConstraintGroup?
  var colorView: UIView?
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

