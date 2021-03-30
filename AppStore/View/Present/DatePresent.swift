//
//  DatePresent.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import UIKit

struct DatePresent: LabelPresentable {
    var textColor: UIColor?
    var isHidden: Bool = false
    var currentVersionReleaseDate: String?
    init(_ model: AppInfo) {
        self.currentVersionReleaseDate = model.currentVersionReleaseDate
    }
    
    var text: String {
        guard let currentVersionReleaseDate = self.currentVersionReleaseDate else { return "" }
        guard let releaseDate = getDate(date: currentVersionReleaseDate) else { return "" }
        guard let dateCompare = dateCompare(fromDate: releaseDate, to: Date()) else { return "" }
        
        return dateConvert(component: dateCompare)        
    }
    
    func getDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: date)
    }
    
    func dateCompare (fromDate: Date, to: Date) -> DateComponents? {
        let cal = NSCalendar(calendarIdentifier:NSCalendar.Identifier(rawValue: NSCalendar.Identifier.gregorian.rawValue))
        let dateComponents = cal?.components([.hour, .day, .month, .year, .minute], from:fromDate, to:to, options:[])
        return dateComponents
    }
    
    func dateConvert(component: DateComponents) -> String {
        if let year = component.year {
            if year != 0 {
                return "\(year)년 전"
            }
        }

        if let month = component.month {
            if month != 0 {
                return "\(month)개월 전"
            }
        }

        if let day = component.day {
            if day != 0 {
                if day < 7 {
                    return "\(day)일 전"
                } else {
                    return "\(day / 7)주 전"
                }
            }
        }

        if let hour = component.hour {
            if hour != 0 {
                return "\(hour)시간 전"
            }
        }

        if let minute = component.minute {
            if minute != 0 {
                return "1시간 전"
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

 
 
