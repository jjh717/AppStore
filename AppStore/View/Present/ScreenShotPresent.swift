//
//  ScreenShotPresent.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import UIKit

class ScreenShotPresent {
    @discardableResult init(_ appInfo: AppInfo?, _ imageViewArr: [CustomImageView]) {
        guard let appInfo = appInfo else { return }
        
        for i in 0..<imageViewArr.count {
            if let screenshotUrls = appInfo.screenshotUrls,
               i < screenshotUrls.count, let imgUrl = URL(string: screenshotUrls[i]) {
                
                imageViewArr[i].loadImageTask(url: imgUrl, placeholder: nil)
            }
        }
    }
}

 
