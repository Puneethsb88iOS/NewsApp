//
//  MockDependencyContainer.swift
//  NewsAppTests
//
//  Created by Puneeth SB on 21/04/22.
//

import Foundation
@testable import NewsApp

extension DependencyContainer {
    
    static func configureMockCloud(_ mockCloud: CloudServiceProtocol) {
        self.shared.register(type: CloudServiceProtocol.self, component: mockCloud.self)
    }
}
