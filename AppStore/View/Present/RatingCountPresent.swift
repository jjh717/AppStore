//
//  RatingCountPresent.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import UIKit

struct RatingCountPresent: LabelPresentable {
    var textColor: UIColor?
    var isHidden: Bool = false
    var userRatingCount: Int?
    var small: Bool
    var decimal: Bool
    
    init(_ model: AppInfo, _ small: Bool, _ decimal: Bool) {
        self.userRatingCount = model.userRatingCount
        self.small = small
        self.decimal = decimal
    }
    
    var text: String {
        guard let userRatingCount = self.userRatingCount else { return "" }
        if decimal {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            guard let result = numberFormatter.string(from: NSNumber(value: userRatingCount)) else { return "" }
            return "\(result)개의 평가"
        } else {
            var resultStr = ""
            if userRatingCount < 1000 {
                resultStr = String(userRatingCount)
            } else if userRatingCount < 10000 { //천단위
                let str = Array(String(userRatingCount))
                resultStr = "\(str[0]).\(str[1])천"
            } else if userRatingCount < 100000 { //만단위
                let str = Array(String(userRatingCount))
                resultStr = "\(str[0]).\(str[1])만"
            } else { //만단위 이상
                let first = userRatingCount / 10000
                let result = userRatingCount - first * 10000
                let second = result / 1000
                resultStr = "\(first).\(second)만"
            }
        
            if self.small {
                return resultStr
            }
        
            return "\(resultStr)개의 평가"
        }
    }
    
    var numberOfLines: Int {
        return 0
    }
    
    var attributedText: NSAttributedString? {
        return nil
    }
}

 
