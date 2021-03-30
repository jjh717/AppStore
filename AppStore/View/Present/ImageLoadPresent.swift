//
//  ImageLoadPresent.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import UIKit

class ImageLoadPresent {
    @discardableResult init(_ urlStr: String?, _ imageView: CustomImageView) {
        guard let url = URL(string: urlStr ?? "") else { return }
        
        imageView.loadImageTask(url: url, placeholder: nil)
    }
}


