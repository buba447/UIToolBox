//
//  UIColor+Toolbox.swift
//  UIToolBox
//
//  Created by Brandon Withrow on 10/10/18.
//

import Foundation
import UIKit

/// Describes a color space for a UIColor
public enum ColorCoordinateSpace {
  /// The Red Green Blue color space.
  case rgb
  /// The Hue Saturation Brightness color space.
  case hsb
  /// A color space that maps color into a 3 dimensional coordinate space.
  case yuv
}

/// A collection of utilities and extensions on UIColor for creating and modifying colors.
public extension UIColor {
  
  // MARK: Initializers
  
  /// Initializes a string with a hex value
  public convenience init(hexString: String) {
    var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
      self.init(white: 0, alpha: 1)
      return
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  /// Initializes a new color with YUV coordinates.
  public convenience init(y: CGFloat, u: CGFloat, v: CGFloat, alpha: CGFloat) {
    // From https://www.fourcc.org/fccyvrgb.php
    let r = y + 1.403 * v
    let g = y - 0.344 * u
    let b = y + 1.770 * u
    self.init(red: r, green: g, blue: b, alpha: alpha)
  }
  
  // MARK: Interpolator
  
  /**
   Interpolates from the recieving color to the given color by an amount from 0-1, You can provide an optional Color coordinate space to perform the interpolation.

   1. The return value is not clipped, values greater than 1 may blow out color.
   2. The different color coordinate spaces will create different color interpolations. HSB generally creates the most pleasing results. YUV and RGB will often pass through grey if the colors are complementary.
   */
  public func interpolateToColor(_ toColor: UIColor, amount: CGFloat, coordinateSpace: ColorCoordinateSpace = .hsb) -> UIColor {
    let returnColor: UIColor
    switch coordinateSpace {
    case .rgb:
      let fromRbg = rgba
      let toRgb = toColor.rgba
      returnColor = UIColor(red: fromRbg.r.interpolate(toRgb.r, amount: amount),
                            green: fromRbg.g.interpolate(toRgb.g, amount: amount),
                            blue: fromRbg.b.interpolate(toRgb.b, amount: amount),
                            alpha: fromRbg.a.interpolate(toRgb.a, amount: amount))
    case .hsb:
      let fromHSB = hsba
      let toHSB = toColor.hsba
      returnColor = UIColor(hue: fromHSB.h.interpolate(toHSB.h, amount: amount),
                            saturation: fromHSB.s.interpolate(toHSB.s, amount: amount),
                            brightness: fromHSB.b.interpolate(toHSB.b, amount: amount),
                            alpha: fromHSB.a.interpolate(toHSB.a, amount: amount))
    case .yuv:
      let fromYUV = yuva
      let toYUV = toColor.yuva
      returnColor = UIColor(y: fromYUV.y.interpolate(toYUV.y, amount: amount),
                            u: fromYUV.u.interpolate(toYUV.u, amount: amount),
                            v: fromYUV.v.interpolate(toYUV.v, amount: amount),
                            alpha: fromYUV.a.interpolate(toYUV.a, amount: amount))
    }
    return returnColor
  }
  
  /// Returns a new color that mixes the receiving color with black
  public func withBlack(black: CGFloat) -> UIColor {
    return interpolateToColor(UIColor.black, amount: black)
  }
  
  /// Returns a new color that mixes the receiving color with white
  public func withWhite(white: CGFloat) -> UIColor {
    return interpolateToColor(UIColor.white, amount: white)
  }
  
  /// Returns a new color created by setting the Hue on the recieving color
  public func withHue(hue: CGFloat) -> UIColor {
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }
  
  /// Returns a new color created by offsetting the Hue on the recieving color
  public func withHueOffset(_ offset: CGFloat) -> UIColor {
    return UIColor(hue: fmod(hue + offset, 1), saturation: saturation, brightness: brightness, alpha: alpha)
  }
  
  /// Returns a new color created by setting the Saturation on the recieving color
  public func withSaturation(saturation: CGFloat) -> UIColor {
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }
  
  /// Returns a new color created by multiplying the saturation by the offset
  public func withSaturationOffset(_ offset: CGFloat) -> UIColor {
    return UIColor(hue: hue, saturation: saturation * offset, brightness: brightness, alpha: alpha)
  }
  
  /// Returns a new color created by setting the Brightness on the recieving color
  public func withBrightness(brightness: CGFloat) -> UIColor {
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }
  
  /// Returns a new color created by multiplying the Brightness by the offset
  public func withBrightnessOffset(_ offset: CGFloat) -> UIColor {
    return UIColor(hue: hue, saturation: saturation, brightness: brightness * offset, alpha: alpha)
  }
  
  // MARK: Color Theory
  
  /// Darkens the color by 20 percent
  public var darker: UIColor {
    return withBrightnessOffset(0.2)
  }
  
  /// Lightens the color by 20 percent
  public var lighter: UIColor {
    return withBrightnessOffset(1.2).withSaturationOffset(0.4)
  }
  
  /// Returns the complementary color of the reciever
  public var complementary: UIColor {
    return withHueOffset(0.5)
  }
  
  /// Returns triadic color pairs as Left and Right
  public var triadic: (left: UIColor, right: UIColor) {
    return (left: withHueOffset(120 / 360), right: withHueOffset(240 / 360))
  }
  
  /// Returns analagous color pairs as Left and Right
  public var analagous: (left: UIColor, right: UIColor) {
    return (left: withHueOffset(-1 / 16), right: withHueOffset(1 / 16))
  }
  
  // MARK: Accessibility
  
  /// Returns the Accessibility luminance contrast between the two colors
  public func contrastRatio(_ withColor: UIColor) -> CGFloat {
    // https://www.w3.org/TR/WCAG20-TECHS/G18.html#G18-tests
    let luminance1 = luminance
    let luminance2 = withColor.luminance
    let luminanceDarker = min(luminance1, luminance2)
    let luminanceLighter = max(luminance1, luminance2)
    return (luminanceLighter + 0.05) / (luminanceDarker + 0.05)
  }
  
  /// Returns true if the contrast between the two colors is accessible
  public func contrastIsAccessible(_ withColor: UIColor) -> Bool {
    return contrastRatio(withColor) > CGFloat(1.0/4.5)
  }
  
  // MARK: Variables
  
  /// Returns the Hue of the color
  public var hue: CGFloat {
    return hsba.h
  }
  
  /// Returns the saturation of the color
  public var saturation: CGFloat {
    return hsba.s
  }
  
  /// returns the brightness of the color
  public var brightness: CGFloat {
    return hsba.b
  }
  
  /// Returns the Accesibility luminance of a color
  public var luminance: CGFloat {
    // From https://www.w3.org/TR/WCAG20-TECHS/G18.html#G18-tests
    return 0.2126 * _adjustComponentForLuminance(red) + 0.7152 * _adjustComponentForLuminance(green) + 0.0722 * _adjustComponentForLuminance(blue)
  }
  
  /// Returns the Red channel of the color
  public var red: CGFloat {
    return rgba.r
  }
  
  /// Returns the Green channel of the color
  public var green: CGFloat {
    return rgba.g
  }
  
  /// Returns the Blue channel of the color
  public var blue: CGFloat {
    return rgba.b
  }
  
  /// Returns the Alpha channel of the color
  public var alpha: CGFloat {
    return hsba.a
  }
  
  // MARK: Private
  
  /// Returns color components in an Hue/Saturation/Brightness color space
  var hsba:(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return (h: h, s: s, b: b, a: a)
  }
  
  /// Returns color components in an Red/Green/Blue color space
  var rgba:(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r: r, g: g, b: b, a: a)
  }
  
  /// Returns color components in an Y'UV Color Space.
  var yuva:(y: CGFloat, u: CGFloat, v: CGFloat, a: CGFloat) {
    /// From https://www.fourcc.org/fccyvrgb.php
    let rgb = rgba
    let y = 0.299 * rgb.r + 0.587 * rgb.g + 0.114 * rgb.b
    let u = -0.14713 * rgb.r - 0.28886 * rgb.g + 0.436 * rgb.b
    let v = 0.615 * rgb.r - 0.51499 * rgb.g - 0.10001 * rgb.b
    return (y: y, u: u, v: v, a: rgb.a)
  }

  fileprivate func _adjustComponentForLuminance(_ colorComponent: CGFloat) -> CGFloat {
    return (colorComponent < 0.03928) ? (colorComponent / 12.92) : pow((colorComponent + 0.055) / 1.055, 2.4)
  }
  
}
