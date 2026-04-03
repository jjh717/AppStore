//
//  BaseViewController.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit
import ReactorKit

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    var standardAppearanceShadowColor: UIColor?
    var standardAppearanceBackgroundColor: UIColor?
    var standardAppearanceBlurEffect: UIBlurEffect?
    let serviceProvider = ServiceProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        if #available(iOS 13.0, *) {
            standardAppearanceShadowColor = self.navigationController?.navigationBar.standardAppearance.shadowColor
            standardAppearanceBackgroundColor = self.navigationController?.navigationBar.standardAppearance.backgroundColor
            standardAppearanceBlurEffect = self.navigationController?.navigationBar.standardAppearance.backgroundEffect
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.standardAppearance.shadowColor = standardAppearanceShadowColor
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = standardAppearanceBackgroundColor
            self.navigationController?.navigationBar.standardAppearance.backgroundEffect = standardAppearanceBlurEffect
        }
    }
    
    func loadXib(type: Any, contentSize: CGRect) -> UITableView? {
        guard let loadedNib = Bundle.main.loadNibNamed(String(describing: type), owner: self, options: nil) else { return nil }
        guard let tableView = loadedNib.first as? UITableView else { return nil }
        tableView.frame = contentSize
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }
}

