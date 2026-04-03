//
//  IndicatorPresent.swift
//  AppStore
//
//  Created by jjh717
//

import Foundation

struct IndicatorPresent: IndicatorViewPresentable {
    var isHidden: Bool = true
    
    init(_ hidden: Bool) {
        self.isHidden = hidden
    }
}
  
