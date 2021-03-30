//
//  SearchViewController.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class SearchViewController: BaseViewController, StoryboardView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "App Store"
        searchController.searchBar.setValue("취소", forKey:"cancelButtonText")
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    var searchListTableView: SearchListTableView?
    var histoyTableView: HistoryTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.reactor = SearchKeywordReactor(provider: serviceProvider)
        setNaviUI(searchController: searchController)
        
        listShowing(index: ViewingList.History.rawValue)
    }
    
    func setNaviUI(searchController: UISearchController) {
        navigationItem.searchController = searchController
        navigationItem.title = "검색"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func bind(reactor: SearchKeywordReactor) {
        searchController.searchBar.rx.text
            .map { Reactor.Action.sortHistory($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
         
        reactor.state.map { $0.isDataLoading }.observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
             
            self.indicator.configure(IndicatorPresent(!$0))
        }).disposed(by: disposeBag)
         
        searchController.searchBar.rx.searchButtonClicked.observeOn(MainScheduler.asyncInstance).asDriver(onErrorJustReturn: ()).drive(onNext: { [weak self] in
            guard let `self` = self else { return }
            guard let text = self.searchController.searchBar.text else { return }

            self.listShowing(index: ViewingList.AppList.rawValue)
            self.searchAction(reactor: reactor, keyword: text, isSave: true)
        }).disposed(by: disposeBag)
            
        searchController.searchBar.rx.cancelButtonClicked.asDriver(onErrorJustReturn: ()).drive(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.listShowing(index: ViewingList.History.rawValue)
        }).disposed(by: disposeBag)
        
        reactor.state.map { $0.viewingListState }
            .observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
          
                self.listShowing(index: $0)
                
        }).disposed(by: disposeBag)
    }
    
    func searchAction(reactor: SearchKeywordReactor, keyword: String, isSave: Bool) {
        Observable.just("")
            .map { _ in Reactor.Action.fetchKeyword(keyword, isSave) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func listShowing(index: Int) {
        if let tableView = self.histoyTableView {
            tableView.removeFromSuperview()
        }
        
        if let tableView = self.searchListTableView {
            tableView.removeFromSuperview()
        }

        if index == ViewingList.AppList.rawValue {
            guard let tableView = loadXib(type: SearchListTableView.self, contentSize: contentView.bounds) as? SearchListTableView else { return }
            
            searchListTableView = tableView
            searchListTableView?.reactor = self.reactor
            tableView.searchListTableViewDelegate = self
            contentView.addSubview(tableView)            
        } else {
            guard let tableView = loadXib(type: HistoryTableView.self, contentSize: contentView.bounds) as? HistoryTableView else { return }
            
            histoyTableView = tableView
            histoyTableView?.reactor = self.reactor
            if index != ViewingList.History.rawValue {
                histoyTableView?.isInitial = true
            }
            tableView.historyTableViewDelegate = self
            contentView.addSubview(tableView)
        }
    }
}

extension SearchViewController: HistoryTableViewDelegate, SearchListTableViewDelegate {    
    func detailSelect(appInfo: AppInfo?) {
        guard let appInfo = appInfo else { return }
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else { return }

        vc.reactor = DetailReactor(provider: serviceProvider, appInfo: appInfo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func historySelect(title: String) {
        guard let reactor = self.reactor else { return }
        self.searchController.searchBar.text = title
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.isActive = true
        
        searchListTableView?.setContentOffset(.zero, animated: false)
        self.searchAction(reactor: reactor, keyword: title, isSave: false)
    }
}
 
