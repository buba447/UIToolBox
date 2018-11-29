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
    
    
    let color = UIColor.orange
    
    let firstGroup = makeColorSquares(color: color)
    view.addSubview(firstGroup)
    firstGroup.pinTopToMargin()
    firstGroup.pinToLeading()
    
    let secondGroup = makeColorSquares(color: color.triadic.left)
    view.addSubview(secondGroup)
    secondGroup.pinToLeading()
    secondGroup.pinBelowView(firstGroup)
    
    let thirdGroup = makeColorSquares(color: color.triadic.right)
    view.addSubview(thirdGroup)
    thirdGroup.pinToLeading()
    thirdGroup.pinBelowView(secondGroup)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func makeColorSquares(color: UIColor) -> UIView {
    let wrapper = UIView()
    
    let firstSquare = UIView(backgroundColor: color)
    let secondSquare = UIView(backgroundColor: color.complementary)
    let thirdSquare = UIView(backgroundColor: color.analagous.left)
    wrapper.addSubview(firstSquare)
    wrapper.addSubview(secondSquare)
    wrapper.addSubview(thirdSquare)
    
    firstSquare.pinToTop()
    firstSquare.pinToLeading()
    firstSquare.pinToBottom()
    firstSquare.constrainSize(CGSize(width: 100, height: 100))
    
    secondSquare.pinLeadingToView(firstSquare)
    secondSquare.constrainSize(CGSize(width: 100, height: 100))
    secondSquare.alignTopToView(firstSquare)
    
    thirdSquare.pinLeadingToView(secondSquare)
    thirdSquare.constrainSize(CGSize(width: 100, height: 100))
    thirdSquare.alignTopToView(secondSquare)
    thirdSquare.pinToTrailing()
    
    return wrapper
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

