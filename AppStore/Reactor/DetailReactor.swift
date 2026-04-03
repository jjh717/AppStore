//
//  DetailReactor.swift
//  AppStore
//
//  Created by jjh717
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift
 
enum CellName: String {
    case AppTitle = "appTitle"
    case ReleaseNote = "releaseNote"
    case ScreenShot = "screenShot"
    case Description = "description"
    case Developer = "developer"
    case Evaluate = "evaluate"
    case Review = "review"
    case Info = "info"
}

class DetailReactor: Reactor {
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, appInfo: AppInfo) {
        self.provider = provider
         
        var path = [Int:String]()
        
        if appInfo.releaseNotes != nil {
            path[0] = CellName.AppTitle.rawValue
            path[1] = CellName.ReleaseNote.rawValue
            path[2] = CellName.ScreenShot.rawValue
            path[3] = CellName.Description.rawValue
            path[4] = CellName.Developer.rawValue
            path[5] = CellName.Evaluate.rawValue
            path[6] = CellName.Review.rawValue
            path[7] = CellName.Info.rawValue
        } else {
            path[0] = CellName.AppTitle.rawValue
            path[1] = CellName.ScreenShot.rawValue
            path[2] = CellName.Description.rawValue
            path[3] = CellName.Developer.rawValue
            path[4] = CellName.Evaluate.rawValue
            path[5] = CellName.Review.rawValue
            path[6] = CellName.Info.rawValue
        }
        
        self.initialState = State(appInfo: appInfo, path: path)
    }
    
    enum Action {
        case setInfoViewHeight(CGFloat)
        case setIsCheckData(Int, Bool)
        case calculateImageSize(CGFloat)
    }
    
    enum Mutation {
        case setInfoViewHeight(Int, CGFloat)
        case setIsCheckData(Int, Bool)
        case calculateImageSize(CGFloat)
    }
    
    struct State {
        var appInfo: AppInfo?
        var path = [Int:String]()
        var convertHeight = [Int:CGFloat]()
        var isCheck = [Int:Bool]()
        let reviews = [Review(userName: "장지훈", starRate: 4.0, time: "2021", content: "안녕하세요. 장지훈입니다.\n처음 뵙겠습니다. \n잘 부탁드립니다.", title: "Hello"),
                       Review(userName: "장지훈", starRate: 4.0, time: "2021", content: "안녕하세요. 장지훈입니다. API에 리뷰 데이터가 없어 테스트 데이터를 넣었습니다.", title: "졸리다...."),
                       Review(userName: "아아", starRate: 4.0, time: "2020", content: "테스트 데이터입니다.", title: "흐암.")]
        
        var iphoneScreenShotSize: CGSize?
        var ipadScreenShotSize: CGSize?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case let .setInfoViewHeight(height):
                var index = 0
                for i in 0..<self.currentState.path.count {
                    if self.currentState.path[i] == CellName.Info.rawValue {
                        index = i
                        break
                    }
                }

                return Observable.just(Mutation.setInfoViewHeight(index, height))
            case let .setIsCheckData(index, check):
                return Observable.just(Mutation.setIsCheckData(index, check))
            case let .calculateImageSize(viewWidth):
                return Observable.just(Mutation.calculateImageSize(viewWidth))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            case let .setInfoViewHeight(index, height):
                newState.convertHeight[index] = height
                newState.isCheck[index] = true
                
            case let .setIsCheckData(index, check):                
                newState.isCheck[index] = check
            case let .calculateImageSize(viewWidth):
                newState.iphoneScreenShotSize = screenShotSizeCalculate(currentState.appInfo?.screenshotUrls, viewWidth)
                newState.ipadScreenShotSize = screenShotSizeCalculate(currentState.appInfo?.ipadScreenshotUrls, viewWidth)
        }
        return newState
    }
     
    func screenShotSizeCalculate(_ screenshotUrls: [String]?, _ viewWidth: CGFloat) -> CGSize? {
        guard let screenshotUrls = screenshotUrls else { return nil }
        if screenshotUrls.count > 0 {
            let arr = screenshotUrls[0].split(separator: "/")
            let fileNameArr = arr[arr.count - 1].split(separator: "x")
            if fileNameArr.count == 2 {
                guard let width = Int(fileNameArr[0]) else {
                    return CGSize(width: 220, height: 391)
                }
                 
                let heightArr = fileNameArr[1].filter("01234567890.".contains)
                let heightStrArr = heightArr.split(separator: ".")
                guard let height = Int(heightStrArr[0]) else {
                    return CGSize(width: 220, height: 391)
                }

                if width > height {
                    let width: CGFloat = viewWidth
                    let height: CGFloat = width / 0.75
                    return CGSize(width: width, height: height)
                } else {
                    return CGSize(width: 220, height: Double(height)*(220.0/Double(width)))
                }
            }
        }
        
        return nil
    }
}
  
