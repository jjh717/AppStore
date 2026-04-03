//
//  HistoryBottomLinePresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct HistoryBottomLinePresent: ImageViewPresentable {
    var isHidden: Bool {
        return self.hidden
    }
    
    var image: UIImage?
    
    var tintColor: UIColor {
        return .clear
    }
    
    var hidden: Bool
    init(_ isInitial: Bool, _ start: Int, _ end: Int) {
        if isInitial {
            self.hidden = false
            return
        }
        if start > end - 1 {
            self.hidden = true
        } else {
            self.hidden = false
        }
    }
    
}
