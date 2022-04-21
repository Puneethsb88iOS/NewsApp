//
//  DependencyContainer.swift
//  NewsApp
//
//  Created by Puneeth SB on 21/04/22.
//

import Foundation

protocol DIContainerProtocol {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) ->Component?
}

/// Dependency Resolver provides Dip container references to the available services in News application.
final class DependencyContainer: DIContainerProtocol {
    
    /// Instance of `DependencyContainer`.
    static let shared = DependencyContainer()
    
    var components: [String: Any] = [:]
    
    func register<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }
    
    func resolve<Component>(type: Component.Type) -> Component? {
        return components["\(type)"] as? Component
    }
    
    /// Dip configuration
    static func configure() {
        // Register Cloud Configuration.
        self.shared.register(type: CloudServiceProtocol.self, component: CloudService().self)
    }
}

// MARK: - DependencyContainer Extension for CloudServiceProtocol
extension DependencyContainer {
    
    /// Resolve dependency using `CloudServiceProtocol`
    ///
    /// - Returns: `CloudServiceProtocol`.
    static func resolveCloudService() -> CloudServiceProtocol {
        return self.shared.resolve(type: CloudServiceProtocol.self)!
    }
}
