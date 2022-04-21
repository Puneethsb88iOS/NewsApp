//
//  HomeScreenViewModel.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit

class HomeScreenViewModel {
    
    var newsDataModel: NewsModel!
    
    /// `CloudServiceProtocol` for cloudService
    var cloudSyncService: CloudServiceProtocol {
        return DependencyContainer.resolveCloudService()
    }
    
    func getMockNewsData() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "MockJson",
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                newsDataModel = try JSONDecoder().decode(NewsModel.self,
                                                    from: jsonData)
            }
        } catch {
            print(error)
        }
    }
    
    func getNewsDetails( completion: @escaping (Bool) -> Void) {
        cloudSyncService.getNews(url: "https://newsapi.org/v2/everything?q=tesla&from=\(Date().dateToString())&sortBy=publishedAt&apiKey=\(AppContant.apiKey)") { result in
            switch result {
            case .success(let data):
                self.newsDataModel = self.parseJson(jsonData: data)
                completion(true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseJson(jsonData: Data) -> NewsModel? {
        do {
            let decodedData = try JSONDecoder().decode(NewsModel.self, from: jsonData)
            print(decodedData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
}
