//
//  Service.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

import Foundation

class BaseService: NSObject {
    unowned let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
