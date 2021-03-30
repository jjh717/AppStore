//
//  Protocol.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/22.
//

import Foundation
import UIKit

protocol TextPresentable {
    var text: String { get }
    var textColor: UIColor? { get }
}
 
protocol ImagePresentable {
    var image: UIImage? { get }
    var tintColor: UIColor { get }
}

protocol ButtonPresentable {
    var isHidden: Bool { get }
}

protocol IndicatorViewPresentable {
    var isHidden: Bool { get }
}

protocol LabelPresentable: TextPresentable {
    var isHidden: Bool { get }
    var numberOfLines: Int { get }
    var attributedText: NSAttributedString? { get }
}

protocol ImageViewPresentable: ImagePresentable {
    var isHidden: Bool { get }
}
 
extension UILabel {
    func configure(_ present: LabelPresentable) {        
        self.isHidden = present.isHidden
        self.textColor = present.textColor
        if present.attributedText != nil {
            self.attributedText = present.attributedText
        } else {
            self.text = present.text
        }
    } 
}

extension UIImageView {
    func configure(_ present: ImageViewPresentable) {
        self.image = present.image
        self.tintColor = present.tintColor
        self.isHidden = present.isHidden
    }
}

extension UIButton {
    func configure(_ present: ButtonPresentable) {
        self.isHidden = present.isHidden
    }
}

extension UIActivityIndicatorView {
    func configure(_ present: IndicatorViewPresentable) {
        self.isHidden = present.isHidden
    }
}
