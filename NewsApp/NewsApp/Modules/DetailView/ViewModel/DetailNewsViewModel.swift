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
}
