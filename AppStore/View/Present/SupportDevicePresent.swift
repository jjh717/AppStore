//
//  SupportDevicePresent.swift
//  AppStore
//
//  Created by j on 2021/03/23.
//

import UIKit

struct SupportDevicePresent: LabelPresentable {
    var textColor: UIColor?
    var isHidden: Bool = false    
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
 
        let systemVersion = UIDevice.current.systemVersion
          
        if userDeviceMatch.count > 0 && (systemVersion.compare(minimumOsVersion, options: .numeric) == .orderedDescending || systemVersion.compare(minimumOsVersion, options: .numeric) == .orderedSame) {
            return "이 \(arr[0])와(과) 호환"
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
 
