//
//  ServiceProvider.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

protocol ServiceProviderType: class {
    var userDefaultsService: UserDefaultsServiceType { get }
    var apiService: APIServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var userDefaultsService: UserDefaultsServiceType = UserDefaultsService(provider: self)
    lazy var apiService: APIServiceType = APIService(provider: self)
}
