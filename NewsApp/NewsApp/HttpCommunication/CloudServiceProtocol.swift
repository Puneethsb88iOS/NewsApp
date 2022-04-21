//
//  CloudServiceProtocol.swift
//  NewsApp
//
//  Created by Puneeth SB on 21/04/22.
//

import Foundation

protocol CloudServiceProtocol {
    func getNews(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
