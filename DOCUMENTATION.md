# UIToolBox

## Documentation

[Back to Readme](README.md)

### AutoLayout
- [ConstraintGroup](#constraintgroup)
- [UIView Autolayout Animation](#uiview-autolayout-animation)
- [UIView Constraints](#uiview-constraints)

### Foundation
- [Double](#double)
- [Array](#array)
- [CGFloat](#cgfloat)
- [CGPoint](#cgpoint)
- [CGSize](#cgsize)
- [CGRect](#cgrect)
- [CGLine](#cgline)

### UI Extensions
- [UIView](#uiview)
- [UIColor](#uicolor)
- [UIBezierPath](#uibezierpath)
- [UIButton](#uibutton)
- [UILabel](#uilabel)
- [UIStackView](#uistackview)
- [UIScrollView](#uiscrollview)
- [UITableView](#uitableview)

## Author

Brandon Withrow, brandon@withrow.io 

## License

UIToolBox is available under the MIT license. See the LICENSE file for more info.

---
---
---

# `ConstraintGroup`

```swift
public struct ConstraintGroup
```

> A group of NSLayoutConstraints. This class provides quick and easy modification to a group of constraints. Typically used for AutoLayout based animations.

## Properties
### `constraints`

```swift
public let constraints: [NSLayoutConstraint]
```

## Methods
### `init(constraints:)`

```swift
public init(constraints: [NSLayoutConstraint])
```

> Initialize with a group of constraints.

### `enable()`

```swift
public func enable()
```

> Enables all constraints in the group.

### `disable()`

```swift
public func disable()
```

> Disables all constraints in the group.

### `setConstant(constant:)`

```swift
public func setConstant(constant: CGFloat)
```
> Sets the constant on all constraints in the group.
---
[Back To Index](#Documentation)


# `UIView Autolayout Animation`

## Methods
### `animateLayoutChanges(style:completion:)`

```swift
public func animateLayoutChanges(style: UIViewAnimationStyle,
completion: ((Bool) -> Void)?)
```

> Auto animates the layout changes of a view using a set style.

# `UIViewAnimationStyle`

```swift
public class UIViewAnimationStyle
```

> Describes a basic animation.

## Properties
### `type`

```swift
public var type: LayoutAnimationType = .easeIn
```

### `speed`

```swift
public var speed: Double = 0.4
```

# `LayoutAnimationType`

```swift
public enum LayoutAnimationType
```

> Enum that describes a basic animation type.

## Cases
### `easeIn`

```swift
case easeIn
```

> An ease-in curve causes the animation to begin slowly, and then speed up as it progresses.

### `easeOut`

```swift
case easeOut
```

> An ease-out curve causes the animation to begin quickly, and then slows down as it progresses.

### `easeInOut`

```swift
case easeInOut
```

> Specify an ease-in ease-out curve, which causes the animation to begin slowly, accelerate through the middle of its duration, and then slow again before completing.

### `spring`

```swift
case spring
```

> A spring based animation curve that overshoots and rests.
> 
---
[Back To Index](#Documentation)

# `UIView Constraints`

### `pinToSuperview(padding:)`

```swift
@discardableResult public func pinToSuperview(padding: CGFloat = 0) -> ConstraintGroup?
```

> Pin view to its superview and returns a ConstraintGroup containing the constraints. Returns nil if superview is nil.

### `pinToSuperviewMargins(padding:)`

```swift
@discardableResult public func pinToSuperviewMargins(padding: CGFloat = 0) -> ConstraintGroup?
```

> Pin view to superview margins and returns a ConstraintGroup containing the constraints. Returns nil if superview is nil.

### `pinToSafeArea()`

```swift
@discardableResult public func pinToSafeArea() -> ConstraintGroup?
```

> Pin view to Safe Area and returns a ConstraintGroup containing the constraints. Returns nil if superview is nil.

### `pinToBottomSafeArea(constant:)`

```swift
@discardableResult public func pinToBottomSafeArea(constant: CGFloat) -> NSLayoutConstraint?
```

> Pins the bottom of the view to the superview's safe area. Returns nil if superview is nil.

### `pinToBottomSafeArea(safeAreaPadding:maxPadding:)`

```swift
@discardableResult public func pinToBottomSafeArea(safeAreaPadding:CGFloat = 0, maxPadding: CGFloat) -> ConstraintGroup?
```

> Pins the bottom of the view to the superview's safe area with a max padding from the bottomAnchor.
>
> This is helpful for pinning a view, such as a button, to the bottom of a view so that
> the spacing is consistent on both iPhone X and iPhone 6-8.
> The button will be pinned to the safe area on iPhone X, or it will be above the bottomAnchor on iPhone 6-8
>
> ```swift
> let button = UIButton()
> view.addSubview(button)
> button.pinToLeadingAndTrailing()
> button.pinToBottomSafeArea(0, maxPadding: 20)
> // Result: The button will be pinned to the safe area on iPhone X, or it will be pinned 20 points above the bottomAnchor on iPhone 8
> ```
>
> - Parameter safeAreaPadding: The amount of padding to place the view above the safeArea.
> - Parameter maxPadding: The amount of padding to plae the view above the bottomAnchor.

#### Parameters

| Name | Description |
| ---- | ----------- |
| safeAreaPadding | The amount of padding to place the view above the safeArea. |
| maxPadding | The amount of padding to plae the view above the bottomAnchor. |

### `pinToCenter()`

```swift
@discardableResult public func pinToCenter() -> ConstraintGroup?
```

> Pin view to superview center.

### `pinToHorizontalCenter(constant:)`

```swift
@discardableResult public func pinToHorizontalCenter(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pins the view to the horizontal center of its superview.

### `pinToVerticalCenter(constant:)`

```swift
@discardableResult public func pinToVerticalCenter(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pins the view to the vertical center of its superview.

### `pinToVerticalCenterOrFit(constant:)`

```swift
@discardableResult public func pinToVerticalCenterOrFit(constant: CGFloat = 0) -> ConstraintGroup?
```

> Pins the view to the vertical center of its superview. The top and bottom anchor are also pinned to be less than and greater to the superview's. This results in a view that fits its superview depending on the superview's content.

### `pinToHorizontalCenterOrFit(constant:)`

```swift
@discardableResult public func pinToHorizontalCenterOrFit(constant: CGFloat = 0) -> ConstraintGroup?
```

> Pins the view to the horizontal center of its superview. The leanding and trailing anchor are also pinned to be less than and greater to the superview's. This results in a view that fits its superview depending on the superview's content.

### `pinLeadingAndTrailingToMargins(constant:)`

```swift
@discardableResult public func pinLeadingAndTrailingToMargins(constant: CGFloat = 0) -> ConstraintGroup?
```

> Pin leading and trailing to superview margins.

### `pinToLeadingAndTrailing(constant:)`

```swift
@discardableResult public func pinToLeadingAndTrailing(constant: CGFloat = 0) -> ConstraintGroup?
```

> Pin leading and trailing to superview.

### `pinMinimumToLeadingAndTrailing(constant:)`

```swift
@discardableResult public func pinMinimumToLeadingAndTrailing(constant: CGFloat = 0) -> ConstraintGroup?
```

> Pins leading and trailing to be greater than or less than the superview's leading and trailing

### `pinToLeading(constant:)`

```swift
@discardableResult public func pinToLeading(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin leading to superview leading

### `pinToTrailing(constant:)`

```swift
@discardableResult public func pinToTrailing(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin trailing to superview trailing

### `pinLeadingToMargin(constant:)`

```swift
@discardableResult public func pinLeadingToMargin(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin leading to superview leading margin

### `pinTrailingToMargin(constant:)`

```swift
@discardableResult public func pinTrailingToMargin(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin trailing to superview trailing margin

### `pinBottomToMargin(constant:)`

```swift
@discardableResult public func pinBottomToMargin(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin top to superview's top margin

### `pinTopToMargin(constant:)`

```swift
@discardableResult public func pinTopToMargin(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin bottom to superview's bottom margin

### `pinToTopAndBottom(constant:)`

```swift
@discardableResult public func pinToTopAndBottom(constant: CGFloat = 0) -> ConstraintGroup?
```

> Pin view to top and bottom of superview

### `pinTopAndBottomToMargin(constant:)`

```swift
@discardableResult public func pinTopAndBottomToMargin(constant: CGFloat = 0) -> ConstraintGroup?
```

> Pin top and bottom to margin of superview

### `pinToTop(constant:)`

```swift
@discardableResult public func pinToTop(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin view to top of superview

### `pinToBottom(constant:)`

```swift
@discardableResult public func pinToBottom(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin view to bottom of superview

### `pinLessThanOrEqualToTrailing(constant:)`

```swift
@discardableResult public func pinLessThanOrEqualToTrailing(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin trailingAnchor to less than or equal to superview's trailingAnchor

### `pinGreaterThanOrEqualToTrailing(constant:)`

```swift
@discardableResult public func pinGreaterThanOrEqualToTrailing(constant: CGFloat = 0) -> NSLayoutConstraint?
```

> Pin leading to less than or equal to superview's leadingAnchor

### `pinHorizontalCenterToView(_:constant:)`

```swift
@discardableResult public func pinHorizontalCenterToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin reciever to target views horizontal center

### `pinVerticalCenterToView(_:constant:)`

```swift
@discardableResult public func pinVerticalCenterToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin reciever to target views vertical center

### `alignTopToView(_:constant:)`

```swift
@discardableResult public func alignTopToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Align the topAnchor with the topAnchor of the given view.

### `alignBottomToView(_:constant:)`

```swift
@discardableResult public func alignBottomToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Align the bottomAnchor with the bottomAnchor of the given view.

### `alignLeadingToView(_:constant:)`

```swift
@discardableResult public func alignLeadingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Align leadingAnchor with the leadingAnchor of the given view.

### `alignTrailingToView(_:constant:)`

```swift
@discardableResult public func alignTrailingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Align trailingAnchor with the trailingAnchor of the given view.

### `alignWidthToView(_:constant:multiplier:)`

```swift
@discardableResult public func alignWidthToView(_ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint
```

> Align the width to the given view

### `alignHeightToView(_:constant:multiplier:)`

```swift
@discardableResult public func alignHeightToView(_ view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint
```

> Align the width to the given view

### `alignToView(_:constant:)`

```swift
@discardableResult public func alignToView(_ view: UIView, constant: CGFloat = 0) -> ConstraintGroup
```

> Align top, bottom, leading, and trailing to given view.

### `pinBelowView(_:constant:)`

```swift
@discardableResult public func pinBelowView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin below given view. Constrains the topAnchor to the bottomAnchor of the given view.

### `pinAboveView(_:constant:)`

```swift
@discardableResult public func pinAboveView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin above given view. Constrains the bottomAnchor to the topAnchor of the given view.

### `pinLeadingToView(_:constant:)`

```swift
@discardableResult public func pinLeadingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin right to given view (Or left in RTL layouts). Constrains leadingAnchor to trailingAnchor of given view.

### `pinLeadingGreaterThanOrEqualToView(_:constant:)`

```swift
@discardableResult public func pinLeadingGreaterThanOrEqualToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin leadingAnchor to be greater than or equal to trailingAnchor of given view.

### `pinTrailingToView(_:constant:)`

```swift
@discardableResult public func pinTrailingToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin left to given view (Or right in RTL layouts). Constrains trailingAnchor to leadingAnchor of given view.

### `pinTrailingLessThanOrEqualToView(_:constant:)`

```swift
@discardableResult public func pinTrailingLessThanOrEqualToView(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint
```

> Pin trailingAnchor to be less than or equal to leadingAnchor of given view.

### `constrainWidth(_:)`

```swift
@discardableResult public func constrainWidth(_ width: CGFloat) -> NSLayoutConstraint
```

> Constrains the view's width

### `constrainHeight(_:)`

```swift
@discardableResult public func constrainHeight(_ height: CGFloat) -> NSLayoutConstraint
```

> Constrains the view's height

### `constrainSize(_:)`

```swift
@discardableResult public func constrainSize(_ size: CGSize) -> ConstraintGroup
```

> Constrains the view's size

### `setMargins(top:leading:bottom:trailing:)`

```swift
public func setMargins(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0)
```

> Sets the layout margins of the view. Convenience safe to use in ios 10+. In iOS 10- this sets layoutMargins. In iOS 11+ it sets directionalLayoutMargins

---
[Back To Index](#Documentation)

# `Double`

## Methods
### `interpolate(_:amount:)`

```swift
public func interpolate(_ toNumber: Double, amount: Double) -> Double
```

> Interpolates the reciever to the given number by Amount.
> - Parameter toNumber: The number to interpolate to.
> - Parameter amount: The amount to interpolate from 0-1
>
> ```
> let number = 5
> let interpolated = number.interpolate(10, amount: 0.5)
> print(interpolated)
> // Result: 7.5
> ```
>
> 1. The amount can be greater than one and less than zero. The interpolation will not be clipped.

#### Parameters

| Name | Description |
| ---- | ----------- |
| toNumber | The number to interpolate to. |
| amount | The amount to interpolate from 0-1 |

### `clamp(_:_:)`

```swift
public func clamp(_ a: Double, _ b: Double) -> Double
```

> Returns a value that is clamped between the two numbers
>
> 1. The order of arguments does not matter.

---
[Back To Index](#Documentation)

# `Array`

## Methods
### `arrayBySubdividing(by:)`

```swift
public func arrayBySubdividing(by: Int) -> Array<Array>
```

> Returns an array that contains the elements of the receiving array nested in child arrays by stride.

### `shift(withDistance:)`

```swift
public func shift(withDistance distance: Int = 1) -> Array<Element>
```

> Returns an array by shifting the elements of the receiving array by distance.

### `shiftInPlace(withDistance:)`

```swift
public mutating func shiftInPlace(withDistance distance: Int = 1)
```

> Shifts the array in place by distance.

---
[Back To Index](#Documentation)

# `CGFloat`

## Methods
### `interpolate(_:amount:)`

```swift
public func interpolate(_ toNumber: CGFloat, amount: CGFloat) -> CGFloat
```

> Interpolates the reciever to the given number by Amount.
> - Parameter toNumber: The number to interpolate to.
> - Parameter amount: The amount to interpolate from 0-1
>
> ```
> let number = 5
> let interpolated = number.interpolate(10, amount: 0.5)
> print(interpolated)
> // Result: 7.5
> ```
>
> 1. The amount can be greater than one and less than zero. The interpolation will not be clipped.

#### Parameters

| Name | Description |
| ---- | ----------- |
| toNumber | The number to interpolate to. |
| amount | The amount to interpolate from 0-1 |

### `clamp(_:_:)`

```swift
public func clamp(_ a: CGFloat, _ b: CGFloat) -> CGFloat
```

> Returns a value that is clamped between the two numbers
>
> 1. The order of arguments does not matter.

### `diff(_:absolute:)`

```swift
public func diff(_ a: CGFloat, absolute: Bool = true) -> CGFloat
```

> Returns the difference between the receiver and the given number.
> - Parameter absolute: If *true* (Default) the returned value will always be positive.

#### Parameters

| Name | Description |
| ---- | ----------- |
| absolute | If  (Default) the returned value will always be positive. |

### `toRadians()`

```swift
public func toRadians() -> CGFloat
```

### `toDegrees()`

```swift
public func toDegrees() -> CGFloat
```

---
[Back To Index](#Documentation)

# `CGPoint`

## Properties
### `vectorLength`

```swift
public var vectorLength: CGFloat
```

> Returns the length between the reciever and *CGPoint.zero*

## Methods
### `distanceFrom(_:)`

```swift
public func distanceFrom(_ a: CGPoint) -> CGFloat
```

> Returns the distance between the reciever and the given point.

### `rounded(decimal:)`

```swift
public func rounded(decimal: CGFloat) -> CGPoint
```

### `interpolate(_:amount:)`

```swift
public func interpolate(_ to: CGPoint, amount: CGFloat) -> CGPoint
```

> Interpolates the reciever to the given Point by Amount.
> - Parameter to: The Point to interpolate to.
> - Parameter amount: The amount to interpolate from 0-1
>
> ```
> let point = CGPoint(width: 50, height: 50)
> let interpolated = rect.interpolate(CGPoint(width: 100, height: 100), amount: 0.5)
> print(interpolated)
> // Result: (x: 75, y: 75)
> ```
>
> 1. The amount can be greater than one and less than zero. The interpolation will not be clipped.

#### Parameters

| Name | Description |
| ---- | ----------- |
| to | The Point to interpolate to. |
| amount | The amount to interpolate from 0-1 |

### `subtract(_:)`

```swift
public func subtract(_ point: CGPoint) -> CGPoint
```

> Subtracts the given point from the receiving point.

### `add(_:)`

```swift
public func add(_ point: CGPoint) -> CGPoint
```

> Adds the given point from the receiving point.

### `/(_:_:)`

```swift
public static func / (lhs: CGPoint, rhs: Float) -> CGPoint
```

> Operator convenience to divide points with /

### `*(_:_:)`

```swift
public static func * (lhs: CGPoint, rhs: Float) -> CGPoint
```

> Operator convenience to multiply points with *

### `+(_:_:)`

```swift
public static func +(left: CGPoint, right: CGPoint) -> CGPoint
```

> Operator convenience to add points with +

### `-(_:_:)`

```swift
public static func -(left: CGPoint, right: CGPoint) -> CGPoint
```

> Operator convenience to subtract points with -

---
[Back To Index](#Documentation)


# `CGSize`

## Methods
### `interpolate(_:amount:)`

```swift
public func interpolate(_ to: CGSize, amount: CGFloat) -> CGSize
```

> Interpolates the reciever to the given size by Amount.
> - Parameter to: The size to interpolate to.
> - Parameter amount: The amount to interpolate from 0-1
>
> ```
> let size = CGSize(width: 50, height: 50)
> let interpolated = rect.interpolate(CGSize(width: 100, height: 100), amount: 0.5)
> print(interpolated)
> // Result: (width: 75, height: 75)
> ```
>
> 1. The amount can be greater than one and less than zero. The interpolation will not be clipped.

#### Parameters

| Name | Description |
| ---- | ----------- |
| to | The size to interpolate to. |
| amount | The amount to interpolate from 0-1 |

### `scaleThatFits(_:)`

```swift
public func scaleThatFits(_ size: CGSize) -> CGFloat
```

> Returns the scale float that will fit the recieve inside of the given size.

### `add(_:)`

```swift
public func add(_ size: CGSize) -> CGSize
```

> Adds reciever size to give size.

### `subtract(_:)`

```swift
public func subtract(_ size: CGSize) -> CGSize
```

> Subtracts given size from reciever size.

### `multiply(_:)`

```swift
public func multiply(_ size: CGSize) -> CGSize
```

> Multiplies reciever size by the given size.

### `+(_:_:)`

```swift
public static func +(left: CGSize, right: CGSize) -> CGSize
```

> Operator convenience to add sizes with +

### `-(_:_:)`

```swift
public static func -(left: CGSize, right: CGSize) -> CGSize
```

> Operator convenience to subtract sizes with -

### `*(_:_:)`

```swift
public static func *(left: CGSize, right: CGFloat) -> CGSize
```

> Operator convenience to multiply sizes with *

---
[Back To Index](#Documentation)

# `CGRect`

## Properties
### `area`

```swift
public var area: CGFloat
```

> Returns the total area of the rect.

### `center`

```swift
public var center: CGPoint
```

> The center point of the rect. Settable.

### `topLeft`

```swift
public var topLeft: CGPoint
```

> The top left point of the rect. Settable.

### `bottomLeft`

```swift
public var bottomLeft: CGPoint
```

> The bottom left point of the rect. Settable.

### `topRight`

```swift
public var topRight: CGPoint
```

> The top right point of the rect. Settable.

### `bottomRight`

```swift
public var bottomRight: CGPoint
```

> The bottom right point of the rect. Settable.

## Methods
### `init(center:size:)`

```swift
public init(center: CGPoint, size: CGSize)
```

> Initializes a new CGRect with a center point and size.

### `interpolate(_:amount:)`

```swift
public func interpolate(_ to: CGRect, amount: CGFloat) -> CGRect
```

> Interpolates the reciever to the given rect by Amount.
> - Parameter to: The rect to interpolate to.
> - Parameter amount: The amount to interpolate from 0-1
>
> ```
> let rect = CGRect(x:0, y:0, width: 50, height: 50)
> let interpolated = rect.interpolate(CGRect(x:100, y:100, width: 100, height: 100), amount: 0.5)
> print(interpolated)
> // Result: (x: 50, y: 50, width: 75, height: 75)
> ```
>
> 1. The amount can be greater than one and less than zero. The interpolation will not be clipped.

#### Parameters

| Name | Description |
| ---- | ----------- |
| to | The rect to interpolate to. |
| amount | The amount to interpolate from 0-1 |

---
[Back To Index](#Documentation)

# `CGLine`

```swift
public struct CGLine
```

> A struct that defines a line segment with two CGPoints

## Properties
### `start`

```swift
public var start: CGPoint
```

> The Start of the line segment.

### `end`

```swift
public var end: CGPoint
```

> The End of the line segment.

### `length`

```swift
public var length: CGFloat
```

> The lenght of the line segment.

## Methods
### `init(start:end:)`

```swift
public init(start: CGPoint, end: CGPoint)
```

> Initializes a line segment with start and end points

### `normalize()`

```swift
public func normalize() -> CGLine
```

> Returns a line sgement that is normalized to a length of 1

### `trimmedToLength(_:)`

```swift
public func trimmedToLength(_ tolength: CGFloat) -> CGLine
```

> Trims a line segment to the given length

### `flipped()`

```swift
public func flipped() -> CGLine
```

> Flips a line vertically and horizontally from the start point.

### `transpose(_:)`

```swift
public func transpose(_ toPoint: CGPoint) -> CGLine
```

> Move the line to the new start point.

---
[Back To Index](#Documentation)

# `UIView`

### `init(backgroundColor:)`

```swift
public convenience init(backgroundColor: UIColor?)
```

> Initializes a view with a background color.

### `setShadow(shadow:)`

```swift
public func setShadow(shadow: LayerShadow?)
```

> Getter/Setter for the layer's corner radius.

# `LayerShadow`

```swift
public struct LayerShadow
```

> Sets a LayerShadow on a UIView

## Properties
### `cornerRadius`

```swift
public var cornerRadius: CGFloat
```

> A struct that wraps shadow styles.

## Properties
### `shadowColor`

```swift
public let shadowColor: UIColor
```

### `shadowOpacity`

```swift
public let shadowOpacity: Float
```

### `shadowRadius`

```swift
public let shadowRadius: CGFloat
```

### `shadowOffset`

```swift
public let shadowOffset: CGSize
```

## Methods
### `init(shadowColor:shadowOpacity:shadowRadius:shadowOffset:)`

```swift
public init(shadowColor: UIColor,
shadowOpacity: Float,
shadowRadius: CGFloat,
shadowOffset: CGSize)
```
---
[Back To Index](#Documentation)

# `UIColor`

## Properties
### `darker`

```swift
public var darker: UIColor
```

> Darkens the color by 20 percent

### `lighter`

```swift
public var lighter: UIColor
```

> Lightens the color by 20 percent

### `complementary`

```swift
public var complementary: UIColor
```

> Returns the complementary color of the reciever

### `triadic`

```swift
public var triadic: (left: UIColor, right: UIColor)
```

> Returns triadic color pairs as Left and Right

### `analagous`

```swift
public var analagous: (left: UIColor, right: UIColor)
```

> Returns analagous color pairs as Left and Right

### `hue`

```swift
public var hue: CGFloat
```

> Returns the Hue of the color

### `saturation`

```swift
public var saturation: CGFloat
```

> Returns the saturation of the color

### `brightness`

```swift
public var brightness: CGFloat
```

> returns the brightness of the color

### `luminance`

```swift
public var luminance: CGFloat
```

> Returns the Accesibility luminance of a color

### `red`

```swift
public var red: CGFloat
```

> Returns the Red channel of the color

### `green`

```swift
public var green: CGFloat
```

> Returns the Green channel of the color

### `blue`

```swift
public var blue: CGFloat
```

> Returns the Blue channel of the color

### `alpha`

```swift
public var alpha: CGFloat
```

> Returns the Alpha channel of the color

### `hsba`

```swift
var hsba:(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)
```

> Returns color components in an Hue/Saturation/Brightness color space

### `rgba`

```swift
var rgba:(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
```

> Returns color components in an Red/Green/Blue color space

### `yuva`

```swift
var yuva:(y: CGFloat, u: CGFloat, v: CGFloat, a: CGFloat)
```

> Returns color components in an Y'UV Color Space.

## Methods
### `init(hexString:)`

```swift
public convenience init(hexString: String)
```

> Initializes a string with a hex value

### `init(y:u:v:alpha:)`

```swift
public convenience init(y: CGFloat, u: CGFloat, v: CGFloat, alpha: CGFloat)
```

> Initializes a new color with YUV coordinates.

### `interpolateToColor(_:amount:coordinateSpace:)`

```swift
public func interpolateToColor(_ toColor: UIColor, amount: CGFloat, coordinateSpace: ColorCoordinateSpace = .hsb) -> UIColor
```

> Interpolates from the recieving color to the given color by an amount from 0-1, You can provide an optional Color coordinate space to perform the interpolation.
>
> 1. The return value is not clipped, values greater than 1 may blow out color.
> 2. The different color coordinate spaces will create different color interpolations. HSB generally creates the most pleasing results. YUV and RGB will often pass through grey if the colors are complementary.

### `withBlack(black:)`

```swift
public func withBlack(black: CGFloat) -> UIColor
```

> Returns a new color that mixes the receiving color with black

### `withWhite(white:)`

```swift
public func withWhite(white: CGFloat) -> UIColor
```

> Returns a new color that mixes the receiving color with white

### `withHue(hue:)`

```swift
public func withHue(hue: CGFloat) -> UIColor
```

> Returns a new color created by setting the Hue on the recieving color

### `withHueOffset(_:)`

```swift
public func withHueOffset(_ offset: CGFloat) -> UIColor
```

> Returns a new color created by offsetting the Hue on the recieving color

### `withSaturation(saturation:)`

```swift
public func withSaturation(saturation: CGFloat) -> UIColor
```

> Returns a new color created by setting the Saturation on the recieving color

### `withSaturationOffset(_:)`

```swift
public func withSaturationOffset(_ offset: CGFloat) -> UIColor
```

> Returns a new color created by multiplying the saturation by the offset

### `withBrightness(brightness:)`

```swift
public func withBrightness(brightness: CGFloat) -> UIColor
```

> Returns a new color created by setting the Brightness on the recieving color

### `withBrightnessOffset(_:)`

```swift
public func withBrightnessOffset(_ offset: CGFloat) -> UIColor
```

> Returns a new color created by multiplying the Brightness by the offset

### `contrastRatio(_:)`

```swift
public func contrastRatio(_ withColor: UIColor) -> CGFloat
```

> Returns the Accessibility luminance contrast between the two colors

### `contrastIsAccessible(_:)`

```swift
public func contrastIsAccessible(_ withColor: UIColor) -> Bool
```

> Returns true if the contrast between the two colors is accessible

---
[Back To Index](#Documentation)

# `ColorCoordinateSpace`

```swift
public enum ColorCoordinateSpace
```

> Describes a color space for a UIColor

## Cases
### `rgb`

```swift
case rgb
```

> The Red Green Blue color space.

### `hsb`

```swift
case hsb
```

> The Hue Saturation Brightness color space.

### `yuv`

```swift
case yuv
```

> A color space that maps color into a 3 dimensional coordinate space.

---
[Back To Index](#Documentation)


# `UIBezierPath`

## Methods
### `init(simpleSmooth:)`

```swift
public convenience init?(simpleSmooth points: [CGPoint])
```

> Simple smoothing algorithm
>
> This iterates through the points in the array, drawing cubic bezier
> from the first to the fourth points, using the second and third as
> control points.
>
> This takes every third point and moves it so that it is exactly inbetween
> the points before and after it, which ensures that there is no discontinuity
> in the first derivative as you join these cubic beziers together.
>
> Note, if, at the end, there are not enough points for a cubic bezier, it
> will perform a quadratic bezier, or if not enough points for that, a line.
>
> - parameter points: The array of `CGPoint`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| points | The array of `CGPoint`. |

### `init(hermiteInterpolatedPoints:closed:)`

```swift
public convenience init?(hermiteInterpolatedPoints points: [CGPoint], closed: Bool)
```

> Create smooth UIBezierPath using Hermite Spline
>
> This requires at least two points.
>
> Adapted from https://github.com/jnfisher/ios-curve-interpolation
> See http://spin.atomicobject.com/2014/05/28/ios-interpolating-points/
>
> - parameter hermiteInterpolatedPoints: The array of CGPoint values.
> - parameter closed:                    Whether the path should be closed or not
>
> - returns:  An initialized `UIBezierPath`, or `nil` if an object could not be created for some reason (e.g. not enough points).

#### Parameters

| Name | Description |
| ---- | ----------- |
| hermiteInterpolatedPoints | The array of CGPoint values. |
| closed | Whether the path should be closed or not |

### `init(catmullRomInterpolatedPoints:closed:alpha:)`

```swift
public convenience init?(catmullRomInterpolatedPoints points: [CGPoint], closed: Bool, alpha: Float)
```

> Create smooth UIBezierPath using Catmull-Rom Splines
>
> This requires at least four points.
>
> Adapted from https://github.com/jnfisher/ios-curve-interpolation
> See http://spin.atomicobject.com/2014/05/28/ios-interpolating-points/
>
> - parameter catmullRomInterpolatedPoints: The array of CGPoint values.
> - parameter closed:                       Whether the path should be closed or not
> - parameter alpha:                        The alpha factor to be applied to Catmull-Rom spline.
>
> - returns:  An initialized `UIBezierPath`, or `nil` if an object could not be created for some reason (e.g. not enough points).

#### Parameters

| Name | Description |
| ---- | ----------- |
| catmullRomInterpolatedPoints | The array of CGPoint values. |
| closed | Whether the path should be closed or not |
| alpha | The alpha factor to be applied to Catmull-Rom spline. |

---
[Back To Index](#Documentation)

# `UIButton`

## Methods
### `init(icon:color:)`

```swift
public convenience init(icon: UIImage, color: UIColor)
```

> Returns a button with the given icon tinted to the given color.

### `init(target:action:)`

```swift
public convenience init(target: Any?, action: Selector)
```

> Returns a new button with target and action

---
[Back To Index](#Documentation)

# `UILabel`

## Methods
### `init(font:textColor:)`

```swift
public convenience init(font: UIFont, textColor: UIColor)
```

> Returns a new Label with font and text color set.

---
[Back To Index](#Documentation)

# `UIStackView`

## Methods
### `removeAllArrangedSubviews()`

```swift
public func removeAllArrangedSubviews()
```

> Removes all arranged subviews from the stackview.

---
[Back To Index](#Documentation)


# `UIScrollView`

## Properties
### `scrollDimension`

```swift
public var scrollDimension: ScrollDimension
```

> The Current scrollable dimension

### `currentPage`

```swift
public var currentPage: Int
```

> The current visible page of the scrollview

### `numberOfPages`

```swift
public var numberOfPages: Int
```

> The number of pages contained by the scrollview

### `pageProgress`

```swift
public var pageProgress: CGFloat
```

> The progress of the current page from 0 to 1

### `visibleRect`

```swift
public var visibleRect: CGRect
```

> The current visible rect of the scrollview

# `ScrollDimension`

```swift
public enum ScrollDimension
```

## Cases
### `width`

```swift
case width
```

### `height`

```swift
case height
```

[Back To Index](#Documentation)

# `UITableView`

## Methods
### `layoutHeaderAndFooter()`

```swift
public func layoutHeaderAndFooter()
```

### `addAutoLayoutHeader(header:)`

```swift
public func addAutoLayoutHeader(header: UIView)
```

> Adds a header to the tableview that is layed out with AutoLayout.

### `addAutoLayoutFooter(footer:)`

```swift
public func addAutoLayoutFooter(footer: UIView)
```

> Adds a footer to the tableview that is layed out with AutoLayout.

### `layoutTableHeaderView()`

```swift
public func layoutTableHeaderView()
```

### `layoutTableFooterView()`

```swift
public func layoutTableFooterView()
```

---
[Back To Index](#Documentation)
