//
//  DetailTableView.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit
import ReactorKit

protocol DetailTableViewDelegate: AnyObject {
    func scroll(_ scrollView: UIScrollView)
}

class DetailTableView: UITableView, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    func bind(reactor: DetailReactor) {
        reactor.state.map { $0.path }.distinctUntilChanged({ (prv, next) -> Bool in
            if Set(prv.keys) == Set(next.keys) {
                return true
            }
            return false
        }).subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.reloadData()
        })
        .disposed(by: disposeBag)
        
        reactor.state.map { $0.convertHeight }
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.beginUpdates()
                self.endUpdates()
            })
            .disposed(by: disposeBag)
    }
    
    typealias Reactor = DetailReactor
    
    weak var detailTableViewDelegate: DetailTableViewDelegate?
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        var nib = UINib(nibName: String(describing: TitleCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: TitleCell.self))
        
        nib = UINib(nibName: String(describing: MoreTextCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: MoreTextCell.self))
        
        nib = UINib(nibName: String(describing: ScreenShotCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: ScreenShotCell.self))
        
        nib = UINib(nibName: String(describing: DeveloperCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: DeveloperCell.self))
        
        nib = UINib(nibName: String(describing: EvaluateCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: EvaluateCell.self))
        
        nib = UINib(nibName: String(describing: ReviewCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: ReviewCell.self))
        
        nib = UINib(nibName: String(describing: InfoCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: InfoCell.self))
        
        nib = UINib(nibName: "DescriptionCell", bundle: nil)
        self.register(nib, forCellReuseIdentifier: "DescriptionCell")
    }     
}

extension DetailTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = reactor?.currentState.convertHeight[indexPath.row] {
            return height
        }
        return UITableView.automaticDimension
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setDetailCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor?.currentState.path.count ?? 0
    }
    
    func setDetailCell(_ indexPath: IndexPath) -> UITableViewCell {
        guard let appInfo = reactor?.currentState.appInfo else { return UITableViewCell() }
        guard let path = reactor?.currentState.path else { return UITableViewCell() }
            
        if path[indexPath.row] == CellName.AppTitle.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self), for: indexPath) as? TitleCell else { return UITableViewCell() }
                
            cell.userRatingLabel.text = ""
            cell.userRatingCountLabel.text = ""
            cell.appIconImageView.image = nil
            cell.appNameLabel.text = ""
            cell.partLabel.text = ""
            cell.ageLabel.text = ""
            cell.appDescLabel.text = ""
            
            cell.userRatingLabel.configure(StarCheckPresent(appInfo, cell.starImageArray))
            cell.userRatingCountLabel.configure(RatingCountPresent(appInfo, false, false))
            
            ImageLoadPresent(appInfo.artworkUrl512, cell.appIconImageView)
 
            cell.appNameLabel.text = appInfo.trackName
            cell.partLabel.text = appInfo.genres?[0]
            cell.ageLabel.text = appInfo.trackContentRating
            cell.appDescLabel.text = appInfo.artistName
            
            return cell
            
        } else if path[indexPath.row] == CellName.ReleaseNote.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: MoreTextCell.self), for: indexPath) as? MoreTextCell else { return UITableViewCell() }
            
            cell.moreTextCellDelegate = self
            cell.index = indexPath.row
            cell.timeLabel.text = ""
            cell.versionLabel.text = ""
            cell.releaseNoteLabel.text = appInfo.releaseNotes
            cell.moreButton.configure(MoreViewingPresent(cell.releaseNoteLabel.actualNumberOfLines, reactor?.currentState.isCheck[indexPath.row] ?? false))
             
            cell.versionLabel.configure(VersionPresent(appInfo))
            cell.timeLabel.configure(DatePresent(appInfo))
            
            return cell
        } else if path[indexPath.row] == CellName.ScreenShot.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: ScreenShotCell.self), for: indexPath) as? ScreenShotCell else { return UITableViewCell() }
                
            cell.reactor = self.reactor
            if let screenshotUrls = appInfo.screenshotUrls {
                cell.screenShotCollectionView.setData(screenshotUrls: screenshotUrls, cellSize: reactor?.currentState.iphoneScreenShotSize)
                if let ipadScreenshotUrls = appInfo.ipadScreenshotUrls {
                    if ipadScreenshotUrls.count > 0 {
                        cell.iPhoneLabel.text = "iPad용 앱 제공"
                        cell.iPhoneIconImageView.image = UIImage(named: "iPadIcon")
                        
                        cell.index = indexPath.row
                        
                        cell.screenShotCellDelegate = self
                        cell.iPadScreenShotCollectionView.setData(screenshotUrls: ipadScreenshotUrls, cellSize: reactor?.currentState.ipadScreenShotSize)
                    } else {
                        cell.dropButton.isHidden = true
                    }
                }
            }
                
            return cell
        } else if path[indexPath.row] == CellName.Description.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? MoreTextCell else { return UITableViewCell() }
                 
            cell.moreTextCellDelegate = self
            cell.releaseNoteLabel.text = appInfo.description
            cell.index = indexPath.row
            cell.moreButton.configure(MoreViewingPresent(cell.releaseNoteLabel.actualNumberOfLines, reactor?.currentState.isCheck[indexPath.row] ?? false))
             
            return cell
        } else if path[indexPath.row] == CellName.Developer.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: DeveloperCell.self), for: indexPath) as? DeveloperCell else { return UITableViewCell() }
                 
            cell.developerLabel.text = appInfo.artistName
            return cell
        } else if path[indexPath.row] == CellName.Evaluate.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: EvaluateCell.self), for: indexPath) as? EvaluateCell else { return UITableViewCell() }
                 
            cell.userRatingLabel.text = ""
            cell.userRatingCountLabel.text = ""
            
            cell.userRatingCountLabel.configure(RatingCountPresent(appInfo, true, false))
            cell.userRatingLabel.configure(DecimalCuttingPresent(appInfo, 2))
 
            return cell
        } else if path[indexPath.row] == CellName.Review.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: ReviewCell.self), for: indexPath) as? ReviewCell else { return UITableViewCell() }
             
            cell.reactor = self.reactor
            
            return cell
        } else if path[indexPath.row] == CellName.Info.rawValue {
            guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: InfoCell.self), for: indexPath) as? InfoCell else { return UITableViewCell() }
            
            cell.reactor = self.reactor             
            cell.setData()
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension DetailTableView: ScreenShotCellDelegate, MoreTextCellDelegate {
    func screenShotDropButtonClick(index: Int?) {
        if let index = index {
            if let cell = self.cellForRow(at: IndexPath(row: index, section: 0)) as? ScreenShotCell {
                cell.iPhoneLabel.text = "iPhone"
                cell.iPhoneIconImageView.image = UIImage(named: "iPhoneIcon")
            }

            UIView.performWithoutAnimation {
                self.beginUpdates()
                self.endUpdates()
            }
        }
    }
    
    func releaseNoteMoreButtonClick(index: Int?) {
        if let index = index {
            guard let reactor = reactor else { return }
            
            Observable.just("")
                .map { _ in Reactor.Action.setIsCheckData(index, true) }
                .bind(to: reactor.action)
                .disposed(by: self.disposeBag)
            
            UIView.performWithoutAnimation {
                self.beginUpdates()
                self.endUpdates()
            }
        }
    }
}

extension DetailTableView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailTableViewDelegate?.scroll(scrollView)
    }
}
