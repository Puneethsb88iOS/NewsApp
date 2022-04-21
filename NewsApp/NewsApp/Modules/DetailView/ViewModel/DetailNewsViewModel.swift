//
//  DetailNewsVieewModel.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import Foundation

class DetailNewsViewModel {
    var webUrl: String!
    var newsDataModel: NewsModel!
    
    init(url: String, newsModel: NewsModel) {
        webUrl = url
        newsDataModel = newsModel
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
}
