//
//  SafariImagePresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct SafariImagePresent: ImageViewPresentable {
    var isHidden: Bool = false
    
    var image: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "safari") ?? nil
        } else {
            return UIImage(named: "safari") ?? nil
        }
    }
    
    var tintColor: UIColor {
        if #available(iOS 13.0, *) {
            return .link
        } else {
            return .blue
        }
    }

    init() {}
}
  
