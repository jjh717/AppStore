//
//  StarCheckPresent.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import UIKit

class StarCheckPresent {
    var averageUserRating: Double = 0
    
    @discardableResult init(_ model: AppInfo?, _ viewArr: [HorizontalView]) {
        averageUserRating = model?.averageUserRating ?? 0
        
        let head = Int(averageUserRating)
        let tail = averageUserRating.truncatingRemainder(dividingBy: 1)

        for i in 0..<viewArr.count {
            if head > i {
                viewArr[i].backgroundColor = .lightGray
            } else {
                viewArr[i].setRating(tail)
                break
            }
        }
    }
}

extension StarCheckPresent: LabelPresentable {
    var textColor: UIColor? {
        return nil
    }    
    
    var numberOfLines: Int {
        return 0
    }
    
    var isHidden: Bool {
        return false
    }
    
    var text: String {
        return self.averageUserRating.demicalCutting(digits: 1)
    }
    
    var attributedText: NSAttributedString? {
        return nil
    }
}

extension Double {
   func demicalCutting(digits: Int) -> String {
       let numberFormatter = NumberFormatter()
       numberFormatter.roundingMode = .floor
       numberFormatter.minimumSignificantDigits = 2
       numberFormatter.maximumSignificantDigits = 2
       return numberFormatter.string(from: NSNumber(value: self)) ?? ""
   }
}
