//
//  DecimalCuttingPresent.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import UIKit

struct DecimalCuttingPresent: LabelPresentable {
    var textColor: UIColor?
    var isHidden: Bool = false    
    var averageUserRating: Double?
    var digits: Int
    init(_ model: AppInfo, _ digits: Int) {
        self.averageUserRating = model.averageUserRating
        self.digits = digits
    }
    
    var text: String {
        guard let averageUserRating = self.averageUserRating else { return "" }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .floor
        numberFormatter.minimumSignificantDigits = self.digits
        numberFormatter.maximumSignificantDigits = self.digits
        return numberFormatter.string(from: NSNumber(value: averageUserRating)) ?? ""
    }
    
    var numberOfLines: Int {
        return 0
    }
    
    var attributedText: NSAttributedString? {
        return nil
    }
}

 
 
