//
//  HandImagePresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct HandImagePresent: ImageViewPresentable {
    var isHidden: Bool = false
    
    var image: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "hand.raised.fill") ?? nil
        } else {
            return UIImage(named: "privacy") ?? nil
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
  
