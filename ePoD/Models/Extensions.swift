//
//  Extensions.swift
//  ePoD
//
//  Created by Tyler Goudie on 3/30/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension Double {
    func rounded(toPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(toPlaces))
        return (self*divisor).rounded() / divisor
    }
}
//MARK:UIColor Extensions
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

//MARK:UIView Extensions
extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor){
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = 12.0
        
        layer.insertSublayer(gradient, at: 0)
    }
}


extension UIButton{
func clearColorForTitle() {

    let buttonSize = bounds.size

    if let font = titleLabel?.font{
        let attribs = [NSAttributedString.Key.font: font]

        if let textSize = titleLabel?.text?.size(withAttributes: attribs){
            UIGraphicsBeginImageContextWithOptions(buttonSize, false, UIScreen.main.scale)

            if let ctx = UIGraphicsGetCurrentContext(){
                ctx.setFillColor(UIColor.white.cgColor)

                let center = CGPoint(x: buttonSize.width / 2 - textSize.width / 2, y: buttonSize.height / 2 - textSize.height / 2)
                let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height))
                ctx.addPath(path.cgPath)
                ctx.fillPath()
                ctx.setBlendMode(.destinationOut)

                titleLabel?.text?.draw(at: center, withAttributes: [NSAttributedString.Key.font: font])

                if let viewImage = UIGraphicsGetImageFromCurrentImageContext(){
                    UIGraphicsEndImageContext()

                    let maskLayer = CALayer()
                    maskLayer.contents = ((viewImage.cgImage) as AnyObject)
                    maskLayer.frame = bounds

                    layer.mask = maskLayer
                }
            }
        }
    }
}
}

extension Numeric{
    init<D: DataProtocol>(_ data: D){
        var value: Self = .zero
        let size = withUnsafeMutableBytes(of: &value, {data.copyBytes(to: $0)})
        assert(size == MemoryLayout.size(ofValue: value))
        self = value
    }
}

extension DataProtocol{
    func value<N: Numeric>() -> N {
        .init(self)
    }
    var integer: Int { value() }
    var int32: Int32 { value() }
    var float: Float { value() }
    var cgFloat: CGFloat { value() }
    var double: Double { value() }
    var decimal: Decimal { value() }
}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}



