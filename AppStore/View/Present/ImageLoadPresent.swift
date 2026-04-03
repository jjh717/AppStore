//
//  ImageLoadPresent.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

class ImageLoadPresent {
    @discardableResult init(_ urlStr: String?, _ imageView: CustomImageView) {
        guard let url = URL(string: urlStr ?? "") else { return }
        
        imageView.loadImageTask(url: url, placeholder: nil)
    }
}


