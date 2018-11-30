//
//  UIView+Animation.swift
//  FourEyes
//
//  Created by Brandon Withrow on 8/29/18.
//  Copyright © 2018 Brandon Withrow. All rights reserved.
//

import Foundation
import UIKit

/// Enum that describes a basic animation type.
public enum LayoutAnimationType {
  /// An ease-in curve causes the animation to begin slowly, and then speed up as it progresses.
  case easeIn
  /// An ease-out curve causes the animation to begin quickly, and then slows down as it progresses.
  case easeOut
  /// Specify an ease-in ease-out curve, which causes the animation to begin slowly, accelerate through the middle of its duration, and then slow again before completing.
  case easeInOut
  /// A spring based animation curve that overshoots and rests.
  case spring
}

// MARK: Animation
extension UIView {
  
  /// Auto animates the layout changes of a view using a set style.
  public func animateLayoutChanges(style: UIViewAnimationStyle,
                            completion: ((Bool) -> Void)?) {
    switch style.type {
    case .easeIn:
      UIView.animate(withDuration: style.speed, delay: 0, options: [UIView.AnimationOptions.curveEaseIn], animations: {
        self.layoutIfNeeded()
      }, completion: completion)
    case .easeOut:
      UIView.animate(withDuration: style.speed, delay: 0, options: [UIView.AnimationOptions.curveEaseOut], animations: {
        self.layoutIfNeeded()
      }, completion: completion)
    case .spring:
      UIView.animate(withDuration: style.speed,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0.1,
                     options: [.curveEaseOut],
                     animations: { self.layoutIfNeeded() },
                     completion: completion)
    case .easeInOut:
      UIView.animate(withDuration: style.speed, delay: 0, options: [UIView.AnimationOptions.curveEaseInOut], animations: {
        self.layoutIfNeeded()
      }, completion: completion)
    }
  }
  
  /// Auto animates the layout changes of a view using a set style.
  public func animateLayoutChanges(style: UIViewAnimationStyle,
                                   withAnimation: @escaping (() -> Void),
                                   completion: ((Bool) -> Void)?) {
    switch style.type {
    case .easeIn:
      UIView.animate(withDuration: style.speed, delay: 0, options: [UIView.AnimationOptions.curveEaseIn], animations: {
        withAnimation()
        self.layoutIfNeeded()
      }, completion: completion)
    case .easeOut:
      UIView.animate(withDuration: style.speed, delay: 0, options: [UIView.AnimationOptions.curveEaseOut], animations: {
        withAnimation()
        self.layoutIfNeeded()
      }, completion: completion)
    case .spring:
      UIView.animate(withDuration: style.speed,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0.1,
                     options: [.curveEaseOut],
                     animations: {
                      withAnimation()
                      self.layoutIfNeeded() },
                     completion: completion)
    case .easeInOut:
      UIView.animate(withDuration: style.speed, delay: 0, options: [UIView.AnimationOptions.curveEaseInOut], animations: {
        self.layoutIfNeeded()
      }, completion: completion)
    }
  }
}

/// Describes a basic animation.
public class UIViewAnimationStyle {
  public var type: LayoutAnimationType = .easeIn
  public var speed: Double = 0.4
}

public extension UIViewAnimationStyle {
  public static var standardEaseIn: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    return style
  }
  
  public static var standardEaseOut: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.type = .easeOut
    return style
  }
  
  public static var standardEaseInOut: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.type = .easeInOut
    return style
  }
  
  public static var standardSpring: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.type = .spring
    return style
  }
  
  public static var fastEaseIn: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.speed = 0.2
    return style
  }
  
  public static var fastEaseOut: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.type = .easeOut
    style.speed = 0.2
    return style
  }
  
  public static var fastEaseInOut: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.type = .easeInOut
    style.speed = 0.2
    return style
  }
  
  public static var fastSpring: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.type = .spring
    style.speed = 0.2
    return style
  }
  
  public static var slowSpring: UIViewAnimationStyle {
    let style = UIViewAnimationStyle()
    style.type = .spring
    style.speed = 0.8
    return style
  }
}
