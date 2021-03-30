//
//  MoreViewingPresent.swift
//  AppStore
//
//  Created by j on 2021/03/23.
//

import Foundation

struct MoreViewingPresent: ButtonPresentable {
    var textline = 0
    var isCheck = false
    init(_ textline: Int, _ isCheck: Bool) {
        self.textline = textline
        self.isCheck = isCheck
    }
    
    var isHidden: Bool {
        if textline > 2 {
            if isCheck {
                return true
            }
        } else {
            return true
        }

        return false
    }
}

  
