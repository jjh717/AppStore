//
//  SearchKeywordReactor.swift
//  AppStore
//
//  Created by jjh717
//

import Foundation
import ReactorKit
import RxCocoa
import RxSwift
 
enum ViewingList: Int {
    case History = 0
    case Initial = 1
    case AppList = 2
}

class SearchKeywordReactor: Reactor {
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        
        if let historyData = self.provider.userDefaultsService.value(forKey: .keyword) {
            self.initialState = State(isDataLoading: false, appInfoData: nil, historyData: historyData, visibleData: historyData)
        } else {
            self.initialState = State(isDataLoading: false, appInfoData: nil)
        }
    }
    
    enum Action {
        case fetchKeyword(String, Bool)
        case sortHistory(String)
    }
    
    enum Mutation {
        case setIsDataLoading(Bool)
        case setHistory([String])
        case setSortHistory([String])
        case setAppInfo([AppInfo])
        case setInitalText(String)
    }
    
    struct State {
        var isDataLoading: Bool = false
        var appInfoData: [AppInfo]?
        var historyData = [String]()
        var visibleData = [String]()
        var initalText = ""
        var viewingListState = 0
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case let .fetchKeyword(value, isSave):
                guard !(self.currentState.isDataLoading) else { return Observable.empty() }
                guard value != "" else { return Observable.empty() }
                
                var arr = provider.userDefaultsService.value(forKey: .keyword)
                if arr == nil, isSave {
                    arr = [String]()
                }
                
                if isSave {
                    if !(arr?.contains(value) ?? true) {
                        arr?.append(value)
                    }
                }

                return Observable.concat([
                    Observable.just(Mutation.setIsDataLoading(true)),
                    Observable.just(provider.userDefaultsService.set(value: arr, forKey: .keyword)).map { Mutation.setHistory(arr ?? []) },
                    Observable.just(Mutation.setAppInfo([])),
                    provider.apiService.searchKeyword(keyword: value).map { Mutation.setAppInfo($0.results) },
                    Observable.just(Mutation.setIsDataLoading(false))
                ])
            case let .sortHistory(value):
                if value == "" {
                    let arr = provider.userDefaultsService.value(forKey: .keyword) ?? []
                    return Observable.just(Mutation.setHistory(arr))
                } else {
                    return Observable.concat([
                        Observable.just(Mutation.setInitalText(value)),
                        Observable.just(Mutation.setSortHistory(initialSort(text: value)))
                    ])
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            case let .setInitalText(obj):
                newState.initalText = obj
            case let .setSortHistory(obj):
                newState.visibleData = obj
                newState.viewingListState = ViewingList.Initial.rawValue
            case let .setIsDataLoading(isLoading):
                newState.isDataLoading = isLoading
            case let .setHistory(value):                
                newState.visibleData = value
                newState.historyData = value
                newState.viewingListState = ViewingList.History.rawValue
            case let .setAppInfo(obj):
                newState.appInfoData = obj
                newState.viewingListState = ViewingList.AppList.rawValue
        }
        return newState
    }
    
    func initialSort(text: String) -> [String] {
        var sortArr = [String]()
        for historyText in self.currentState.historyData {
            if (historyText.lowercased() as NSString).range(of: text.lowercased()).lowerBound == 0 {
                sortArr.append(historyText)
            }
        }
        return sortArr
    }
}
  
