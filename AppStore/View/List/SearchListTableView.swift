//
//  SearchListTableView.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit
import ReactorKit

protocol SearchListTableViewDelegate: AnyObject {
    func detailSelect(appInfo: AppInfo?)
}

class SearchListTableView: UITableView, ReactorKit.View {
    weak var searchListTableViewDelegate: SearchListTableViewDelegate?
    
    var disposeBag = DisposeBag()
    typealias Reactor = SearchKeywordReactor
    
    func bind(reactor: SearchKeywordReactor) {
        self.rx.setDelegate(self).disposed(by: disposeBag)
        
        reactor.state.map { ($0.appInfoData ?? []) }.bind(to: self.rx.items) { (tableView, row, item) -> UITableViewCell in
 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchListTableViewCell.self), for: IndexPath(row: row, section: 0)) as? SearchListTableViewCell else { return UITableViewCell() }
 
            let appInfo = item
            StarCheckPresent(appInfo, cell.starImageArray)
            
            cell.appNameLabel.text = appInfo.trackName
            cell.appDescLabel.text = appInfo.genres?[0]
                        
            cell.userRatingCountLabel.configure(RatingCountPresent(appInfo, true, false))
             
            ImageLoadPresent(appInfo.artworkUrl100, cell.appIconImageView)
            ScreenShotPresent(appInfo, [cell.main_1_ImageView, cell.main_2_ImageView, cell.main_3_ImageView])
             
            return cell
        }.disposed(by: disposeBag)
        
        self.rx.itemSelected.subscribe(onNext: { [weak self, weak reactor] indexPath in
            guard let self else { return }
            guard let reactor = reactor else { return }
             
            self.searchListTableViewDelegate?.detailSelect(appInfo: reactor.currentState.appInfoData?[indexPath.row])
        }).disposed(by: disposeBag)
    }
    
    override func awakeFromNib() {
         setupUI()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: String(describing: SearchListTableViewCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: SearchListTableViewCell.self))
    }
}

extension SearchListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
 
