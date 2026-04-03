//
//  InitalLabelPresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct InitalLabelPresent: LabelPresentable {
    var textColor: UIColor? {
        if userInterfaceStyle == .dark {
            return .gray
        } else {
            return .lightGray
        }
    }
    
    var isHidden: Bool = false
    
    var numberOfLines: Int = 0
    
    var attributedText: NSAttributedString? {
        let attributedStr = NSMutableAttributedString(string: text)

        if userInterfaceStyle == .dark {
            attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: (text.lowercased() as NSString).range(of: initalText.lowercased()))
        } else {
            attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: (text.lowercased() as NSString).range(of: initalText.lowercased()))
        }

        return attributedStr
    }

    var initalText: String = ""
    var text: String = ""
    var userInterfaceStyle: UIUserInterfaceStyle?
    init(_ text: String, _ initalText: String, _ userInterfaceStyle: UIUserInterfaceStyle) {
        self.text = text
        self.initalText = initalText
        self.userInterfaceStyle = userInterfaceStyle
    }
}
  
 
