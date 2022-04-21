//
//  HomeScreenViewModel.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit

class HomeScreenViewModel: HomeScreenViewModelInputs, HomeScreenViewModelOutputs, HomeScreenViewModelType {
    
    let title = ["Top News", "Popular News"]
    var inputs: HomeScreenViewModelInputs { return self }
    var outputs: HomeScreenViewModelOutputs { return self }
    var newsDataModel: NewsModel!
    
    /// `CloudServiceProtocol` for cloudService
    var cloudSyncService: CloudServiceProtocol {
        return DependencyContainer.resolveCloudService()
    }
    
    func getNewsDetails( completion: @escaping (Bool) -> Void) {
        cloudSyncService.getNews(url: "https://newsapi.org/v2/everything?q=tesla&from=\(Date().dateToString())&sortBy=publishedAt&apiKey=\(AppContant.apiKey)") { result in
            switch result {
            case .success(let data):
                self.parseJson(jsonData: data)
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func parseJson(jsonData: Data) {
        do {
            newsDataModel = try JSONDecoder().decode(NewsModel.self, from: jsonData)
        } catch {}
    }
}

protocol HomeScreenViewModelInputs {}

protocol HomeScreenViewModelOutputs {
    func getNewsDetails( completion: @escaping (Bool) -> Void)
    func parseJson(jsonData: Data)
}

protocol HomeScreenViewModelType {
    var inputs: HomeScreenViewModelInputs { get }
    var outputs: HomeScreenViewModelOutputs { get }
}
