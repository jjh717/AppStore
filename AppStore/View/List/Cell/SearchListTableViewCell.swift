//
//  SearchListTableViewCell.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class SearchListTableViewCell: UITableViewCell {
    @IBOutlet var appIconImageView: CustomImageView!
    
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var appDescLabel: UILabel!
    
    var starImageArray = [HorizontalView]()
    @IBOutlet var star_1_View: HorizontalView!
    @IBOutlet var star_2_View: HorizontalView!
    @IBOutlet var star_3_View: HorizontalView!
    @IBOutlet var star_4_View: HorizontalView!
    @IBOutlet var star_5_View: HorizontalView!
     
    @IBOutlet var userRatingCountLabel: UILabel!
    
    @IBOutlet var main_1_ImageView: CustomImageView!
    @IBOutlet var main_2_ImageView: CustomImageView!
    @IBOutlet var main_3_ImageView: CustomImageView!
    
    @IBOutlet weak var downloadButton: UIButton!
     
    override func awakeFromNib() {
        starImageArray.append(star_1_View)
        starImageArray.append(star_2_View)
        starImageArray.append(star_3_View)
        starImageArray.append(star_4_View)
        starImageArray.append(star_5_View)
    }
    
     override func prepareForReuse() {
        super.prepareForReuse()
        self.appIconImageView.image = nil
        self.main_1_ImageView.image = nil
        self.main_2_ImageView.image = nil
        self.main_3_ImageView.image = nil
        
        self.appIconImageView.loadStop()
        self.main_1_ImageView.loadStop()
        self.main_2_ImageView.loadStop()
        self.main_3_ImageView.loadStop()
    }
}
