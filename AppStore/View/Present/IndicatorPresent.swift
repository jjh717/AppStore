//
//  IndicatorPresent.swift
//  AppStore
//
//  Created by j on 2021/03/25.
//

import Foundation

struct IndicatorPresent: IndicatorViewPresentable {
    var isHidden: Bool = true
    
    init(_ hidden: Bool) {
        self.isHidden = hidden
    }
}
  
