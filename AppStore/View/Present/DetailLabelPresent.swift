//
//  DetailLabelPresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct DetailLabelPresent: LabelPresentable {
    var textColor: UIColor?
    var text: String    
    var hidden = true
    init(_ isHidden: Bool?) {
        self.hidden = isHidden ?? true
        self.text = ""
    }
    
    var isHidden: Bool {        
        return self.hidden
    }
    
    var numberOfLines: Int {
        return 0
    }
    
    var attributedText: NSAttributedString? {
        return nil
    }
}
  
