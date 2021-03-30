//
//  InfoDetailTableView.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/21.
//

import UIKit
import ReactorKit

protocol InfoDetailTableViewDelegate: class {
    func calculateHeight(index: Int)
}

class InfoDetailTableView: UITableView, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    func bind(reactor: InfoDetailReactor) {
        reactor.state.map { $0.path }.distinctUntilChanged({ (prv, next) -> Bool in
            if Set(prv.keys) == Set(next.keys) {
                return true
            }
            return false
        }).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
             
            self.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    typealias Reactor = InfoDetailReactor
    
    weak var infoDetailTableViewDelegate: InfoDetailTableViewDelegate?
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: String(describing: InfoDetailCell.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: InfoDetailCell.self))
    }     
}

extension InfoDetailTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor?.currentState.path.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appInfo = self.reactor?.currentState.appInfo
        
        if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.compatibility.rawValue ||
            reactor?.currentState.path[indexPath.row] == InfoDetailCellName.language.rawValue ||
            reactor?.currentState.path[indexPath.row] == InfoDetailCellName.ageDegree.rawValue {
            
            if let cell = tableView.cellForRow(at: indexPath) as? InfoDetailCell {
                cell.sideView.isHidden = true
                cell.detailLabel.isHidden = false
                
                self.beginUpdates()
                self.endUpdates()

                infoDetailTableViewDelegate?.calculateHeight(index: indexPath.row)

                guard let reactor = reactor else { return }
                Observable.just("")
                    .map { _ in Reactor.Action.setIsCheckData(indexPath.row, false) }
                    .bind(to: reactor.action)
                    .disposed(by: self.disposeBag)
            }
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.sellerUrl.rawValue {
            if let sellerUrl = appInfo?.sellerUrl {
                if let url = URL(string: sellerUrl) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.privacy.rawValue {
            if let sellerUrl = appInfo?.sellerUrl {
                if let url = URL(string: sellerUrl) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appInfo = self.reactor?.currentState.appInfo
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InfoDetailCell.self), for: indexPath) as? InfoDetailCell else { return UITableViewCell() }
            
        if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.sellerName.rawValue {
            cell.titleLabel.text = "제공자"
            cell.contentLabel.text = appInfo?.sellerName
            cell.stateImageView.isHidden = true
            cell.detailLabel.isHidden = true
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.fileSize.rawValue {
            cell.titleLabel.text = "크기"
            cell.contentLabel.configure(ByteToMegaPresent(appInfo))
            cell.stateImageView.isHidden = true
            cell.detailLabel.isHidden = true
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.category.rawValue {
            cell.titleLabel.text = "카테고리"
            cell.contentLabel.text = appInfo?.primaryGenreName
            cell.stateImageView.isHidden = true
            cell.detailLabel.isHidden = true
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.compatibility.rawValue {
            cell.detailLabel.configure(DetailLabelPresent(reactor?.currentState.isCheck[indexPath.row]))
            cell.titleLabel.text = "호환성"
            cell.contentLabel.configure(SupportDevicePresent(appInfo))
            cell.detailLabel.configure(SupportMultiDevicePresent(appInfo))
              
            if #available(iOS 13.0, *) {
                cell.stateImageView.image = UIImage(systemName: "chevron.down")
            }
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.language.rawValue {
            cell.detailLabel.configure(DetailLabelPresent(reactor?.currentState.isCheck[indexPath.row]))
            cell.titleLabel.text = "언어"
            cell.contentLabel.configure(SupportLanguageLocaleMatchingPresent(appInfo))
            cell.detailLabel.configure(SupportLanguagePresent(appInfo))
             
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.ageDegree.rawValue {
            cell.detailLabel.configure(DetailLabelPresent(reactor?.currentState.isCheck[indexPath.row]))
            cell.titleLabel.text = "연령 등급"
            if let trackContentRating = appInfo?.trackContentRating {
                cell.contentLabel.text = "\(trackContentRating)"
                cell.detailLabel.text = "\(trackContentRating)"
            }
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.literaryProperty.rawValue {
            cell.titleLabel.text = "저작권"
            
            cell.stateImageView.isHidden = true
            cell.detailLabel.isHidden = true
            
            if let artistName = appInfo?.artistName {
                cell.contentLabel.text = "ⓒ \(artistName)"
            }
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.sellerUrl.rawValue {
            cell.titleLabel.text = "개발자 웹 사이트"

            cell.detailLabel.isHidden = true
            cell.contentLabel.isHidden = true
            
            if #available(iOS 13.0, *) {
                cell.titleLabel.textColor = .link
                cell.stateImageView.configure(SafariImagePresent())
            } else {
                cell.titleLabel.textColor = .systemBlue
            }
        } else if reactor?.currentState.path[indexPath.row] == InfoDetailCellName.privacy.rawValue {
            cell.titleLabel.text = "개인정보 처리방침"
            
            cell.detailLabel.isHidden = true
            cell.contentLabel.isHidden = true
            
            if #available(iOS 13.0, *) {
                cell.titleLabel.textColor = .link                
                cell.stateImageView.configure(HandImagePresent())
            } else {
                cell.titleLabel.textColor = .systemBlue
            }
        }

        return cell
    }
    
    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
}

