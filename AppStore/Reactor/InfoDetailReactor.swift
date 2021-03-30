//
//  InfoDetailReactor.swift
//  AppStore
//
//  Created by j on 2021/03/23.
//

import Foundation
import ReactorKit

enum InfoDetailCellName: String {
    case sellerName = "sellerName"
    case fileSize = "fileSize"
    case category = "category"
    case compatibility = "compatibility"
    case language = "language"
    case ageDegree = "ageDegree"
    case literaryProperty = "literaryProperty"
    case sellerUrl = "sellerUrl"
    case privacy = "privacy"
}

class InfoDetailReactor: Reactor {
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, appInfo: AppInfo?) {
        self.provider = provider
         
        if let appInfo = appInfo {
            var path = [Int:String]()
            var index = 0
            if (appInfo.sellerName) != nil {
                path[index] = InfoDetailCellName.sellerName.rawValue
                index += 1
            }
            
            if (appInfo.fileSizeBytes) != nil {
                path[index] = InfoDetailCellName.fileSize.rawValue
                index += 1
            }
            
            if (appInfo.primaryGenreName) != nil {
                path[index] = InfoDetailCellName.category.rawValue
                index += 1
            }
            
            if let supportedDevices = appInfo.supportedDevices {
                if supportedDevices.count > 0 {
                    path[index] = InfoDetailCellName.compatibility.rawValue
                    index += 1
                }
            }
            
            if let languageCodesISO2A = appInfo.languageCodesISO2A {
                if languageCodesISO2A.count > 0 {
                    path[index] = InfoDetailCellName.language.rawValue
                    index += 1
                }
            }

            if (appInfo.trackContentRating) != nil {
                path[index] = InfoDetailCellName.ageDegree.rawValue
                index += 1
            }

            if (appInfo.artistName) != nil {
                path[index] = InfoDetailCellName.literaryProperty.rawValue
                index += 1
            }
            
            if (appInfo.sellerUrl) != nil {
                path[index] = InfoDetailCellName.sellerUrl.rawValue
                index += 1
            }
            
            //개발자 웹 사이트로 대체
            if (appInfo.sellerUrl) != nil {
                path[index] = InfoDetailCellName.privacy.rawValue
                index += 1
            }
            
            self.initialState = State(appInfo: appInfo, path: path)
        } else {
            self.initialState = State(appInfo: appInfo)
        }
    }
    
    enum Action {
         case setIsCheckData(Int, Bool)
    }
    
    enum Mutation {
         case setIsCheckData(Int, Bool)
    }
    
    struct State {
        var appInfo: AppInfo?
        var path = [Int:String]()
        var isCheck = [Int:Bool]()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case let .setIsCheckData(index, check):
                return Observable.just(Mutation.setIsCheckData(index, check))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
             case let .setIsCheckData(index, check):
                newState.isCheck[index] = check
        }
        return newState
    }
     
}
  
