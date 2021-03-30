//
//  DetailViewController.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

import UIKit
import ReactorKit

class DetailViewController: UIViewController, StoryboardView {
    var disposeBag = DisposeBag()
    
    func bind(reactor: DetailReactor) {
        detailTableView.layoutIfNeeded()
        Observable.just("")
            .map { _ in Reactor.Action.calculateImageSize(self.detailTableView.frame.size.width) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    typealias Reactor = DetailReactor
    
    @IBOutlet weak var detailTableView: DetailTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
    
    func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.shadowColor = nil
            appearance.shadowImage = nil
            appearance.backgroundColor = UIColor(named: "whiteNBlack")
            self.navigationController?.navigationBar.standardAppearance = appearance
        }
    }
 
    func setupUI() {        
        detailTableView.reactor = self.reactor
        detailTableView.detailTableViewDelegate = self
    }
}

extension DetailViewController: DetailTableViewDelegate {
    func scroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            if self.navigationController != nil {
                navigationItem.titleView?.isHidden = false
                
                if #available(iOS 13.0, *) {
                    self.navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
                    if self.traitCollection.userInterfaceStyle == .dark {
                        self.navigationController?.navigationBar.standardAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialDark)
                    } else {
                        self.navigationController?.navigationBar.standardAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialLight)
                    }
                }
            }
        } else {
            if self.navigationController != nil {
                navigationItem.titleView?.isHidden = true
                
                if #available(iOS 13.0, *) {
                    self.navigationController?.navigationBar.standardAppearance.shadowColor = nil
                    self.navigationController?.navigationBar.standardAppearance.shadowImage = nil
                    self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(named: "whiteNBlack")
                    self.navigationController?.navigationBar.standardAppearance.backgroundEffect = nil
                }
            }
        }
    }
}


