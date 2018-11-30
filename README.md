# UIToolBox

[![Version](https://img.shields.io/cocoapods/v/UIToolBox.svg?style=flat)](https://cocoapods.org/pods/UIToolBox)
[![License](https://img.shields.io/cocoapods/l/UIToolBox.svg?style=flat)](https://cocoapods.org/pods/UIToolBox)
[![Platform](https://img.shields.io/cocoapods/p/UIToolBox.svg?style=flat)](https://cocoapods.org/pods/UIToolBox)

UIToolBox is a set of tools, extensions, and classes for developing UI for iOS in Swift. Many of the extensions are Missing Features and easy to use helpers for creating readable code.

The library breaks down into three major parts: 
- **Auto Layout Extensions**: Easy to use extensions for creating and animating constraints.
- **Foundation Extensions**: Missing functions and helpers for many Foundation objects. (EG Add, Subtract, Multiply two CGPoints! Get a UIColor's complement)
- **UI Extensions**: Clean and easy helper functions for several common UI functions.


See documentation below for full list of functions.

## Installation

UIToolBox is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UIToolBox'
```

## Example

![Example](/images/Example.gif)

Say we want to create a view that animates its position and size using AutoLayout:

```swift
import UIKit
import UIToolBox

let view = UIView()

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

/// Now lets animate from one constraint group to another with a spring animation.

topConstraint.disable()
bottomConstraint.enable()
view.animateLayoutChanges(
style: .slowSpring,
withAnimation: {
/// Animate the background color to its complementary.
colorView.backgroundColor = color.complementary
}) { (complete) in
/// Animation complete!
}
```

## Documentation

[Read the full documentation here](DOCUMENTATION.md)

## Author

Brandon Withrow, brandon@withrow.io 

## License

UIToolBox is available under the MIT license. See the LICENSE file for more info.
