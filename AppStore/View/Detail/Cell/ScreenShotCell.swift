//
//  ScreenShotCell.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/21.
//

import UIKit
import ReactorKit

protocol ScreenShotCellDelegate: class {
    func screenShotDropButtonClick(index: Int?)
}

class ScreenShotCell: UITableViewCell, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    func bind(reactor: DetailReactor) {        
        reactor.state.map { $0.iphoneScreenShotSize }
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                 
                self.screenShotCollectionViewHeight.constant = $0?.height ?? 0
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.ipadScreenShotSize }
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                self.iPadScreenShotCollectionViewHeight.constant = $0?.height ?? 0
            })
            .disposed(by: disposeBag)
     }
    
    typealias Reactor = DetailReactor
    
    weak var screenShotCellDelegate: ScreenShotCellDelegate?
    @IBOutlet weak var screenShotCollectionView: ScreenShotCollectionView!
    @IBOutlet weak var screenShotCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var iPadScreenShotCollectionView: ScreenShotCollectionView!
    @IBOutlet weak var iPadScreenShotCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var iPadScreenShotContentView: UIStackView!
    
    @IBOutlet weak var iPhoneIconImageView: UIImageView!
    @IBOutlet weak var iPhoneLabel: UILabel!
    
    var index: Int?
    
    override func awakeFromNib() {
        screenShotCollectionView.decelerationRate = .fast
        iPadScreenShotCollectionView.decelerationRate = .fast
    }
    
    @IBAction func dropButtonClick(_ sender: Any) {
        iPadScreenShotContentView.isHidden = false
        dropButton.isHidden = true
        screenShotCellDelegate?.screenShotDropButtonClick(index: index)
    }     
}
