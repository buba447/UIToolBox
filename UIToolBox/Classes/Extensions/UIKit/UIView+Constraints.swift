import Foundation
import UIKit

/// A group of NSLayoutConstraints. This class provides quick and easy modification to a group of constraints. Typically used for AutoLayout based animations.
public struct ConstraintGroup {
  
  /// Initialize with a group of constraints.
  public init(constraints: [NSLayoutConstraint]) {
    self.constraints = constraints
  }
  
  public let constraints: [NSLayoutConstraint]
  
  /// Enables all constraints in the group.
  public func enable() {
    for constraint in constraints {
      constraint.isActive = true
    }
  }
  
  /// Disables all constraints in the group.
  public func disable() {
    for constraint in constraints {
      constraint.isActive = false
    }
  }
  
  /// Sets the constant on all constraints in the group.
  public func setConstant(constant: CGFloat) {
    for constraint in constraints {
      constraint.constant = constant
    }
  }
}

public extension UIView {
  
  // MARK: Pinning to Superview
  
  /// Pin view to its superview and returns a ConstraintGroup containing the constraints. Returns nil if superview is nil.
  @discardableResult public func pinToSuperview(padding: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let group = ConstraintGroup(constraints: [
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
      group.enable()
      return group
    }
    return nil
  }
  
  /// Pin view to superview margins and returns a ConstraintGroup containing the constraints. Returns nil if superview is nil.
  @discardableResult public func pinToSuperviewMargins(padding: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let group = ConstraintGroup(constraints: [
      leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: padding),
      trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -padding),
      topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: padding),
      bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -padding)
      ])
      group.enable()
      return group
    }
    return nil
  }
  
  /// Pin view to Safe Area and returns a ConstraintGroup containing the constraints. Returns nil if superview is nil.
  @discardableResult public func pinToSafeArea() -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      if #available(iOS 11.0, *) {
        let group = ConstraintGroup(constraints: [
        leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
        trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
        ])
        group.enable()
        return group
      } else {
        let group = ConstraintGroup(constraints: [
        leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor),
        trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor),
        topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
        bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
        ])
        group.enable()
        return group
      }
    }
    return nil
  }
  
  /// Pins the bottom of the view to the superview's safe area. Returns nil if superview is nil.
  @discardableResult public func pinToBottomSafeArea(constant: CGFloat) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      if #available(iOS 11.0, *) {
        let constraint = bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
        constraint.isActive = true
        return constraint
      } else {
        let constraint = bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant)
        constraint.isActive = true
        return constraint
      }
    }
    return nil
  }
  
  /**
   Pins the bottom of the view to the superview's safe area with a max padding from the bottomAnchor.
   
   This is helpful for pinning a view, such as a button, to the bottom of a view so that
   the spacing is consistent on both iPhone X and iPhone 6-8.
   The button will be pinned to the safe area on iPhone X, or it will be above the bottomAnchor on iPhone 6-8
   
   ```swift
   let button = UIButton()
   view.addSubview(button)
   button.pinToLeadingAndTrailing()
   button.pinToBottomSafeArea(0, maxPadding: 20)
   // Result: The button will be pinned to the safe area on iPhone X, or it will be pinned 20 points above the bottomAnchor on iPhone 8
   ```
   
   - Parameter safeAreaPadding: The amount of padding to place the view above the safeArea.
   - Parameter maxPadding: The amount of padding to plae the view above the bottomAnchor.
   */
  @discardableResult public func pinToBottomSafeArea(safeAreaPadding:CGFloat = 0, maxPadding: CGFloat) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      if #available(iOS 11.0, *) {
        let constraint1 = bottomAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaPadding)
        constraint1.priority = UILayoutPriority.required
        constraint1.isActive = true
        
        let constraint2 = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -maxPadding)
        constraint2.priority = UILayoutPriority.defaultLow
        constraint2.isActive = true
        return ConstraintGroup(constraints: [constraint1, constraint2])
      } else {
        let constraint1 = bottomAnchor.constraint(lessThanOrEqualTo: superview.layoutMarginsGuide.bottomAnchor, constant: -safeAreaPadding)
        constraint1.priority = UILayoutPriority.required
        constraint1.isActive = true
        
        let constraint2 = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -maxPadding)
        constraint2.priority = UILayoutPriority.defaultLow
        constraint2.isActive = true
        return ConstraintGroup(constraints: [constraint1, constraint2])
      }
    }
    return nil
  }
  
  /// Pin view to superview center.
  @discardableResult public func pinToCenter() -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let group = ConstraintGroup(constraints: [
      centerXAnchor.constraint(equalTo: superview.centerXAnchor),
      centerYAnchor.constraint(equalTo: superview.centerYAnchor)
      ])
      group.enable()
      return group
    }
    return nil
  }
  
  /// Pins the view to the horizontal center of its superview.
  @discardableResult public func pinToHorizontalCenter(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      return pinHorizontalCenterToView(superview, constant: constant)
    }
    return nil
  }
  
  /// Pins the view to the vertical center of its superview.
  @discardableResult public func pinToVerticalCenter(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      return pinVerticalCenterToView(superview, constant: constant)
    }
    return nil
  }
  
  /// Pins the view to the vertical center of its superview. The top and bottom anchor are also pinned to be less than and greater to the superview's. This results in a view that fits its superview depending on the superview's content.
  @discardableResult public func pinToVerticalCenterOrFit(constant: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let group = ConstraintGroup(constraints: [
      centerYAnchor.constraint(equalTo: superview.centerYAnchor),
      topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor, constant: constant),
      bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor, constant: -constant)
        ])
        group.enable()
        return group
    }
    return nil
  }
  
  /// Pins the view to the horizontal center of its superview. The leanding and trailing anchor are also pinned to be less than and greater to the superview's. This results in a view that fits its superview depending on the superview's content.
  @discardableResult public func pinToHorizontalCenterOrFit(constant: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let group = ConstraintGroup(constraints: [
        centerXAnchor.constraint(equalTo: superview.centerXAnchor),
        leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: constant),
        trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: -constant)
        ])
      group.enable()
      return group
    }
    return nil
  }
  
  /// Pin leading and trailing to superview margins.
  @discardableResult public func pinLeadingAndTrailingToMargins(constant: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let group = ConstraintGroup(constraints: [
      leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: constant),
      trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: constant)
      ])
      group.enable()
      return group
    }
    return nil
  }
  
  /// Pin leading and trailing to superview.
  @discardableResult public func pinToLeadingAndTrailing(constant: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let one = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant)
      one.isActive = true
      let two = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
      two.isActive = true
      return ConstraintGroup(constraints: [one, two])
    }
    return nil
  }
  
  /// Pins leading and trailing to be greater than or less than the superview's leading and trailing
  @discardableResult public func pinMinimumToLeadingAndTrailing(constant: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let one = leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: constant)
      one.isActive = true
      let two = trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: -constant)
      two.isActive = true
      return ConstraintGroup(constraints: [one, two])
    }
    return nil
  }
  
  /// Pin leading to superview leading
  @discardableResult public func pinToLeading(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      return alignLeadingToView(superview, constant: constant)
    }
    return nil
  }
  
  /// Pin trailing to superview trailing
  @discardableResult public func pinToTrailing(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      return alignTrailingToView(superview, constant: constant)
    }
    return nil
  }
  
  /// Pin leading to superview leading margin
  @discardableResult public func pinLeadingToMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let constraint = leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: constant)
      constraint.isActive = true
      return constraint
    }
    return nil
  }
  
  /// Pin trailing to superview trailing margin
  @discardableResult public func pinTrailingToMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let constraint = trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: constant)
      constraint.isActive = true
      return constraint
    }
    return nil
  }
  
  /// Pin top to superview's top margin
  @discardableResult public func pinBottomToMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let bottomConstraint = bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant)
      bottomConstraint.isActive = true
      return bottomConstraint
    }
    return nil
  }
  
  /// Pin bottom to superview's bottom margin
  @discardableResult public func pinTopToMargin(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let topconstraint = topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant)
      topconstraint.isActive = true
      return topconstraint
    }
    return nil
  }
  
  /// Pin view to top and bottom of superview
  @discardableResult public func pinToTopAndBottom(constant: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let top = alignTopToView(superview, constant: constant)
      let bottom = alignBottomToView(superview, constant: constant)
      return ConstraintGroup(constraints: [top, bottom])
    }
    return nil
  }
  
  /// Pin top and bottom to margin of superview
  @discardableResult public func pinTopAndBottomToMargin(constant: CGFloat = 0) -> ConstraintGroup? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
      let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
      top.isActive = true
      bottom.isActive = true
      return ConstraintGroup(constraints: [top, bottom])
    }
    return nil
  }
  
  /// Pin view to top of superview
  @discardableResult public func pinToTop(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      return alignTopToView(superview, constant: constant)
    }
    return nil
  }
  
  /// Pin view to bottom of superview
  @discardableResult public func pinToBottom(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      return alignBottomToView(superview, constant: constant)
    }
    return nil
  }
  
  /// Pin trailingAnchor to less than or equal to superview's trailingAnchor
  @discardableResult public func pinLessThanOrEqualToTrailing(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superView = superview {
      let constraint = trailingAnchor.constraint(lessThanOrEqualTo: superView.trailingAnchor, constant: -constant)
      constraint.isActive = true
      return constraint
    }
    return nil
  }
  
  /// Pin leading to less than or equal to superview's leadingAnchor
  @discardableResult public func pinGreaterThanOrEqualToTrailing(constant: CGFloat = 0) -> NSLayoutConstraint? {
    translatesAutoresizingMaskIntoConstraints = false
    if let superView = superview {
      let constraint = leadingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: constant)
      constraint.isActive = true
      return constraint
    }
    return nil
  }
  
  // MARK: Pinning to views
  
  /// Pin reciever to target views horizontal center
  @discardableResult public func pinHorizontalCenterToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Pin reciever to target views vertical center
  @discardableResult public func pinVerticalCenterToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Align the topAnchor with the topAnchor of the given view.
  @discardableResult public func alignTopToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Align the bottomAnchor with the bottomAnchor of the given view.
  @discardableResult public func alignBottomToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Align leadingAnchor with the leadingAnchor of the given view.
  @discardableResult public func alignLeadingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Align trailingAnchor with the trailingAnchor of the given view.
  @discardableResult public func alignTrailingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Align the width to the given view
  @discardableResult public func alignWidthToView(_ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Align the width to the given view
  @discardableResult public func alignHeightToView(_ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Align top, bottom, leading, and trailing to given view.
  @discardableResult public func alignToView(_ view: UIView, constant: CGFloat = 0) -> ConstraintGroup {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint1 = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
    let constraint2 = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
    let constraint3 = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
    let constraint4 = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
    let group = ConstraintGroup(constraints: [constraint1, constraint2, constraint3, constraint4])
    group.enable()
    return group
  }
  
  /// Pin below given view. Constrains the topAnchor to the bottomAnchor of the given view.
  @discardableResult public func pinBelowView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }

  /// Pin above given view. Constrains the bottomAnchor to the topAnchor of the given view.
  @discardableResult public func pinAboveView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant)
    constraint.isActive = true
    return constraint
  }
  
  
  /// Pin right to given view (Or left in RTL layouts). Constrains leadingAnchor to trailingAnchor of given view.
  @discardableResult public func pinLeadingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Pin leadingAnchor to be greater than or equal to trailingAnchor of given view.
  @discardableResult public func pinLeadingGreaterThanOrEqualToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = leadingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Pin left to given view (Or right in RTL layouts). Constrains trailingAnchor to leadingAnchor of given view.
  @discardableResult public func pinTrailingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -constant)
    constraint.isActive = true
    return constraint
  }
  
  /// Pin trailingAnchor to be less than or equal to leadingAnchor of given view.
  @discardableResult public func pinTrailingLessThanOrEqualToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = trailingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: -constant)
    constraint.isActive = true
    return constraint
  }

  /// Constrains the view's width
  @discardableResult public func constrainWidth(_ width: CGFloat) -> NSLayoutConstraint {
    let constraint = widthAnchor.constraint(equalToConstant: width)
    constraint.isActive = true
    return constraint
  }
  
  /// Constrains the view's height
  @discardableResult public func constrainHeight(_ height: CGFloat) -> NSLayoutConstraint {
    let constraint = heightAnchor.constraint(equalToConstant: height)
    constraint.isActive = true
    return constraint
  }
  
  /// Constrains the view's size
  @discardableResult public func constrainSize(_ size: CGSize) -> ConstraintGroup {
    return ConstraintGroup(constraints: [constrainWidth(size.width), constrainHeight(size.height)])
  }
  
  /// Sets the layout margins of the view. Convenience safe to use in ios 10+. In iOS 10- this sets layoutMargins. In iOS 11+ it sets directionalLayoutMargins
  public func setMargins(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
    if #available(iOS 11.0, *) {
      // Running iOS 11 OR NEWER
      directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    } else {
      // Earlier version of iOS
      layoutMargins = UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
    }
  }
  
}

public extension UIViewController {
  
  /// Convenience Method for setting safe area pre ios 11
  public func setSafeAreaInsets(insets: UIEdgeInsets) {
    if #available(iOS 11.0, *) {
      self.additionalSafeAreaInsets = insets
    }
  }
}
