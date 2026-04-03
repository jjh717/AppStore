//
//  ByteToMegaPresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

struct ByteToMegaPresent: LabelPresentable {
    var textColor: UIColor?
    var isHidden: Bool = false
    var fileSizeBytes: String?
    
    init(_ model: AppInfo?) {
        self.fileSizeBytes = model?.fileSizeBytes
    }
    
    var text: String {
        guard let fileSizeBytes = self.fileSizeBytes else { return "" }
        guard let bytes = Int(fileSizeBytes) else { return "" }
        
        return "\(String(format: "%.1f",  Double(bytes / 1024 / 1024)))MB"
    }
    
    var numberOfLines: Int {
        return 0
    }
    
    var attributedText: NSAttributedString? {
        return nil
    }
}

 
