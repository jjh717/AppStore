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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        standardAppearanceShadowColor = appearance.shadowColor
        standardAppearanceBackgroundColor = appearance.backgroundColor
        standardAppearanceBlurEffect = appearance.backgroundEffect
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = standardAppearanceShadowColor
        appearance.backgroundColor = standardAppearanceBackgroundColor
        appearance.backgroundEffect = standardAppearanceBlurEffect
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func loadXib(type: Any, contentSize: CGRect) -> UITableView? {
        guard let loadedNib = Bundle.main.loadNibNamed(String(describing: type), owner: self, options: nil) else { return nil }
        guard let tableView = loadedNib.first as? UITableView else { return nil }
        tableView.frame = contentSize
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }
}

