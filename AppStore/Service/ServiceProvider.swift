//
//  ServiceProvider.swift
//  AppStore
//
//  Created by jjh717
//

protocol ServiceProviderType: AnyObject {
    var userDefaultsService: UserDefaultsServiceType { get }
    var apiService: APIServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var userDefaultsService: UserDefaultsServiceType = UserDefaultsService(provider: self)
    lazy var apiService: APIServiceType = APIService(provider: self)
}
