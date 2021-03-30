//
//  SupportLanguageLocaleMatchingPresent.swift
//  AppStore
//
//  Created by j on 2021/03/23.
//

import UIKit

struct SupportLanguageLocaleMatchingPresent: LabelPresentable {
    var textColor: UIColor?
    var isHidden: Bool = false
    var languageCodesISO2A: [String]?
    init(_ model: AppInfo?) {
        self.languageCodesISO2A = model?.languageCodesISO2A
    }
    
    var text: String {
        guard let languageCodesISO2A = self.languageCodesISO2A else { return "" }
        
        if languageCodesISO2A.count == 1 {
            return "\(languageCodesISO2A[0].languageCodeConvert())"
        } else {
            let localeID = Locale.preferredLanguages.first
            var lanCode = "KO"
            if let deviceLocale = (Locale(identifier: localeID!).languageCode) {
                lanCode = deviceLocale
            }
                
            let match = languageCodesISO2A.filter({(item: String) -> Bool in
                return (item.lowercased().range(of: lanCode.lowercased())) != nil ? true : false
            })
            
            if match.count > 0 {
                return "\(match[0].languageCodeConvert()) 외 \(languageCodesISO2A.count)개"
            }
        }
 
        return ""
    }
    
    var numberOfLines: Int {
        return 0
    }
    
    var attributedText: NSAttributedString? {
        return nil
    }
}
  
