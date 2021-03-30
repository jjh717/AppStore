//
//  HorizontalView.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

import UIKit
 
class HorizontalView: UIView {
    var Rating: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setRating(_ Rating: Double) {
        self.Rating = Rating
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let topRect = CGRect(x: 0, y: 0, width: rect.size.width * CGFloat( self.Rating ), height: rect.size.height)
        UIColor.lightGray.set()
        guard let topContext = UIGraphicsGetCurrentContext() else { return }
        topContext.fill(topRect) 
    }
}
