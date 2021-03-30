//
//  UserReviewCell.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/21.
//

import UIKit

class UserReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var star_1_view: UIImageView!
    @IBOutlet weak var star_2_view: UIImageView!
    @IBOutlet weak var star_3_view: UIImageView!
    @IBOutlet weak var star_4_view: UIImageView!
    @IBOutlet weak var star_5_view: UIImageView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
}
