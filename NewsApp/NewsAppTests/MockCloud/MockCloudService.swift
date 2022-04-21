//
//  MockCloudService.swift
//  NewsAppTests
//
//  Created by Puneeth SB on 21/04/22.
//

import Foundation
@testable import NewsApp

class MockCloudService: CloudServiceProtocol {
    
    /// `Bool` value to handle `getNews` response status in test cases.
    var getNewsResponseSuccess: Bool = true
    
    /// `Int` value to handle `getNews` service request call count in test cases.
    var getNewsRequestCallCount = 0
    
    func getNews(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        var result: Result<Data, Error>
        getNewsRequestCallCount += 1
        if getNewsResponseSuccess {
            if let bundlePath = Bundle.main.path(forResource: "MockJson", ofType: "json"),
               let jsonData = try! String(contentsOfFile: bundlePath).data(using: .utf8) {
                result = .success(jsonData)
                completion(result)
            }
        }
        else {
            result = .failure(error.test)
            completion(result)
        }
    }
    
    enum error: Error {
        case test
    }
}
