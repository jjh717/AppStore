//
//  TitleCell.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit

class TitleCell: UITableViewCell {
    @IBOutlet weak var appIconImageView: CustomImageView!
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appDescLabel: UILabel!
    
    var starImageArray = [HorizontalView]()
    @IBOutlet weak var star_1_View: HorizontalView!
    @IBOutlet weak var star_2_View: HorizontalView!
    @IBOutlet weak var star_3_View: HorizontalView!
    @IBOutlet weak var star_4_View: HorizontalView!
    @IBOutlet weak var star_5_View: HorizontalView!
    
    @IBOutlet weak var userRatingCountLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var partLabel: UILabel!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        starImageArray.append(star_1_View)
        starImageArray.append(star_2_View)
        starImageArray.append(star_3_View)
        starImageArray.append(star_4_View)
        starImageArray.append(star_5_View)
    }
}
