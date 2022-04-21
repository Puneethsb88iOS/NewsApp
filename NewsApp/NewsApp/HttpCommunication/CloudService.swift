//
//  CloudService.swift
//  NewsApp
//
//  Created by Puneeth SB on 21/04/22.
//

import Foundation

class CloudService: CloudServiceProtocol {
    func getNews(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let headers = ["content-type": "application/json"]
        guard let url = URL(string: url) else { return }
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        })
        dataTask.resume()
    }
    
    
}
