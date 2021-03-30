//
//  HistoryLabelPresent.swift
//  AppStore
//
//  Created by j on 2021/03/25.
//

import UIKit

struct HistoryLabelPresent: LabelPresentable {
    var textColor: UIColor? {
        return .systemBlue
    }
    
    var isHidden: Bool = false
    
    var numberOfLines: Int = 0
    
    var attributedText: NSAttributedString?
    
    var text: String = ""
    
    init(_ text: String) {
        self.text = text
    }
}
  
