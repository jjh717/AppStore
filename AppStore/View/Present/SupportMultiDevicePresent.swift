//
//  SupportMultiDevicePresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct SupportMultiDevicePresent: LabelPresentable {
    var textColor: UIColor?    
    var isHidden: Bool = true
    var supportedDevices: [String]?
    var minimumOsVersion = "0.0.0"
    init(_ model: AppInfo?) {
        self.supportedDevices = model?.supportedDevices
        self.minimumOsVersion = model?.minimumOsVersion ?? "0.0.0"
    }
    
    var text: String {
        guard let supportedDevices = self.supportedDevices else { return "" }
         
        var modelName = UIDevice.modelName.stringTrim()
        #if DEBUG
            modelName = "iPhone X"
        #endif
        
        let arr =  modelName.components(separatedBy: " ")
        modelName = "\(arr[0])\(arr[1])"
        
        let userDeviceMatch = supportedDevices.filter({(item: String) -> Bool in
            return (item.lowercased().range(of: modelName.lowercased())) != nil ? true : false
        })
 
        let iPadDeviceMatch = supportedDevices.filter({(item: String) -> Bool in
            return (item.lowercased().range(of: "ipad".lowercased())) != nil ? true : false
        })
        
        let iPodDeviceMatch = supportedDevices.filter({(item: String) -> Bool in
            return (item.lowercased().range(of: "ipod".lowercased())) != nil ? true : false
        })
        
        let watchDeviceMatch = supportedDevices.filter({(item: String) -> Bool in
            return (item.lowercased().range(of: "watch".lowercased())) != nil ? true : false
        })
        
        let systemVersion = UIDevice.current.systemVersion
          
        if userDeviceMatch.count > 0 && (systemVersion.compare(minimumOsVersion, options: .numeric) == .orderedDescending || systemVersion.compare(minimumOsVersion, options: .numeric) == .orderedSame) {
            var detailStr = "iOS \(minimumOsVersion)"
            
            if watchDeviceMatch.count > 0 {
                if (watchDeviceMatch[0].lowercased().range(of: "Watch4".lowercased()) != nil) {
                    detailStr += " 및 watchOS 4.0"
                } else if (watchDeviceMatch[0].lowercased().range(of: "Watch3".lowercased()) != nil) {
                    detailStr += " 및 watchOS 3.0"
                } else if (watchDeviceMatch[0].lowercased().range(of: "Watch2".lowercased()) != nil) {
                    detailStr += " 및 watchOS 2.0"
                }
            }

            if iPadDeviceMatch.count > 0 && iPodDeviceMatch.count > 0 {
                return "\(detailStr) 버전 이상이 필요. \(arr[0]), iPad 및 iPod touch 기기와 호환됨."
            } else if iPadDeviceMatch.count > 0 {
                return "\(detailStr) 버전 이상이 필요. \(arr[0]), iPad 기기와 호환됨."
            } else if iPodDeviceMatch.count > 0 {
                return "\(detailStr) 버전 이상이 필요. \(arr[0]), iPod touch 기기와 호환됨."
            } else {
                return "\(detailStr) 버전 이상이 필요. \(arr[0]) 기기와(과) 호환."
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
  
