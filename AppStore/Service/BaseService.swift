//
//  Service.swift
//  AppStore
//
//  Created by jjh717
//

import Foundation

class BaseService: NSObject {
    unowned let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
