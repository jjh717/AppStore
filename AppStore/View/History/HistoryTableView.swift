//
//  HistoryTableView.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

import UIKit
import ReactorKit

protocol HistoryTableViewDelegate: class {
    func historySelect(title: String)
}

class HistoryTableView: UITableView, ReactorKit.View {
    weak var historyTableViewDelegate: HistoryTableViewDelegate?
    var isInitial = false
    var disposeBag = DisposeBag()
    typealias Reactor = SearchKeywordReactor
     
    func bind(reactor: SearchKeywordReactor) {
        reactor.state.map { $0.visibleData }.bind(to: self.rx.items) { [weak self, weak reactor] (tableView, row, item) -> UITableViewCell in
            guard let `self` = self else { return UITableViewCell() }
            guard let reactor = reactor else { return UITableViewCell() }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self), for: IndexPath(row: row, section: 0)) as? HistoryTableViewCell else { return UITableViewCell() }

            cell.searchImageView.isHidden = !self.isInitial
            cell.titleLabel.textColor = .lightGray
            
            cell.bottomLineImageView.configure(HistoryBottomLinePresent(self.isInitial, row, reactor.currentState.visibleData.count))
            
            if self.isInitial {
                cell.titleLabel.configure(InitalLabelPresent(item, reactor.currentState.initalText, self.traitCollection.userInterfaceStyle))
            } else {
                cell.titleLabel.configure(HistoryLabelPresent(item))
            }
            
            return cell
            
        }.disposed(by: disposeBag)
        
        self.rx.itemSelected.subscribe(onNext: { [weak self, weak reactor] indexPath in
            guard let `self` = self else { return }
            guard let reactor = reactor else { return }
             
            let title = reactor.currentState.visibleData[indexPath.row]
            self.historyTableViewDelegate?.historySelect(title: title)
        }).disposed(by: disposeBag)
    }
    
    override func awakeFromNib() {
        setupUI()
    }
      
    private func setupUI() {
        var nib = UINib(nibName: String(describing: HistoryTableViewCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))
        
        nib = UINib(nibName: String(describing: HistoryTitleTableViewCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: HistoryTitleTableViewCell.self))
    }
}
 
