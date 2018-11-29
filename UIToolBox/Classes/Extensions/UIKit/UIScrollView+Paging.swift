//
//  UIScrollView+Paging.swift
//  FourEyes
//
//  Created by Brandon Withrow on 8/30/18.
//  Copyright © 2018 Brandon Withrow. All rights reserved.
//

import Foundation
import UIKit

public enum ScrollDimension {
  case width
  case height
}

extension UIScrollView {
  
  /// The Current scrollable dimension
  public var scrollDimension: ScrollDimension {
    get {
      return contentSize.width > bounds.size.width ? .width : .height
    }
  }
  
  /// The current visible page of the scrollview
  public var currentPage: Int {
    get {
      let returnValue: Int
      switch scrollDimension {
      case .width:
        returnValue = Int(floor( contentOffset.x / bounds.size.width ))
      case .height:
        returnValue = Int(floor( contentOffset.y / bounds.size.height ))
      }
      return min(numberOfPages - 1, max(returnValue, 0))
    }
  }
  
  /// The number of pages contained by the scrollview
  public var numberOfPages: Int {
    let returnValue: Int
    switch scrollDimension {
    case .width:
      returnValue = Int(floor( contentSize.width / bounds.size.width ))
    case .height:
      returnValue = Int(floor( contentSize.height / bounds.size.height ))
    }
    return returnValue
  }
  
  /// The progress of the current page from 0 to 1
  public var pageProgress: CGFloat {
    let returnValue: CGFloat
    switch scrollDimension {
    case .width:
      returnValue = (contentOffset.x / bounds.width)
    case .height:
      returnValue = (contentOffset.y / bounds.height)
    }
    return min(CGFloat(numberOfPages - 1), max(returnValue, 0))
  }
  
}

extension UIScrollView {
  
  /// The current visible rect of the scrollview
  public var visibleRect: CGRect {
    return CGRect(origin: contentOffset, size: bounds.size)
  }
  
}
