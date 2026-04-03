//
//  InfoCell.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit
import ReactorKit
 
class InfoCell: UITableViewCell, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    func bind(reactor: DetailReactor) {
        
    }
    
    typealias Reactor = DetailReactor
     
    @IBOutlet weak var infoDetailTableView: InfoDetailTableView!
    @IBOutlet weak var detailTableViewHeight: NSLayoutConstraint!
     
    func setData() {
        infoDetailTableView.infoDetailTableViewDelegate = self
        let infoDetailReactor = InfoDetailReactor(provider: ServiceProvider(), appInfo: reactor?.currentState.appInfo)
        infoDetailTableView.reactor = infoDetailReactor
        let frame = infoDetailTableView.rectForRow(at: IndexPath(row: 0, section: 0))
        detailTableViewHeight.constant = CGFloat(infoDetailReactor.currentState.path.count) * frame.size.height
    }
}

extension InfoCell: InfoDetailTableViewDelegate {
    func calculateHeight(index: Int) {
        guard let reactor = reactor else { return }
        
        var totalHeight: CGFloat = infoDetailTableView.frame.origin.y
        for i in 0..<reactor.currentState.path.count {
            let frame = infoDetailTableView.rectForRow(at: IndexPath(row: i, section: 0))
            totalHeight += frame.size.height
        }
        
        detailTableViewHeight.constant = totalHeight
         
        Observable.just("")
            .map { _ in Reactor.Action.setInfoViewHeight(totalHeight) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
 

