//
//  AttributedString.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 1/12/20.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    var fontSize: CGFloat { return 30 }
    var boldFont: UIFont { return UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont: UIFont { return UIFont.systemFont(ofSize: fontSize)}

    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: 25),
            .foregroundColor : UIColor.label
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func boldWhite(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: 25),
            .foregroundColor : UIColor.systemBackground
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func boldGreen(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: 25),
            .foregroundColor : UIColor.systemGreen
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func boldRed(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: 25),
            .foregroundColor : UIColor.systemRed
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func boldBlue(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: 25),
            .foregroundColor : UIColor.systemBlue
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 25),
            .foregroundColor : UIColor.label
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal20 (_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 25),
            .foregroundColor : UIColor.label
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal30 (_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 30),
            .foregroundColor : UIColor.label
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func bold30 (_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: 30),
            .foregroundColor : UIColor.label
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
