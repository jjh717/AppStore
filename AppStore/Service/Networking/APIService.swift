//
//  APIService.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

import Foundation
import RxSwift

protocol APIServiceType {
    func searchKeyword(keyword: String) -> Observable<AppInfoDict>
}

final class APIService: BaseService, APIServiceType {    
    func searchKeyword(keyword: String) -> Observable<AppInfoDict> {
        return send(apiRequest: UserEndpoint.search(term: keyword).asURLRequest())
    }         
     
    func send<T: Codable>(apiRequest: URLRequest) -> Observable<T> {
        return Observable<T>.create { [unowned self] observer in
            let task = URLSession.shared.dataTask(with: apiRequest) { (data, response, error) in
                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                    
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
