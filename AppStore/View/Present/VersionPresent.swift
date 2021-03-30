//
//  VersionPresent.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import UIKit

struct VersionPresent: LabelPresentable {
    var textColor: UIColor?    
    var isHidden: Bool = false    
    var version: String?
    init(_ model: AppInfo) {
        self.version = model.version
    }
    
    var text: String {
        if let version = self.version {
            return "버전 \(version)"
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
