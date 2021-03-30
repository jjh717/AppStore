//
//  Navi+Extension.swift
//  AppStore
//
//  Created by j on 2021/03/24.
//

import Foundation
import UIKit
extension UINavigationController {
    func addLogoImage(image: UIImage) {
        let bannerWidth = self.navigationItem.accessibilityFrame.size.width
        let bannerHeight = self.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2

        let imageView = UIImageView(image:image)
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
}
