//
//  SupportLanguagePresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct SupportLanguagePresent: LabelPresentable {
    var textColor: UIColor?
    var isHidden: Bool = true
    var languageCodesISO2A: [String]?
    init(_ model: AppInfo?) {
        self.languageCodesISO2A = model?.languageCodesISO2A
    }
    
    var text: String {
        guard let languageCodesISO2A = self.languageCodesISO2A else { return "" }
        
        var result = ""
        for i in 0..<languageCodesISO2A.count {
            if i == languageCodesISO2A.count - 1 {
                result += "\(languageCodesISO2A[i].languageCodeConvert())"
            } else {
                result += "\(languageCodesISO2A[i].languageCodeConvert()), "
            }
        }
        return result
    }
    
    var numberOfLines: Int {
        return 0
    }
    
    var attributedText: NSAttributedString? {
        return nil
    }
}
  
