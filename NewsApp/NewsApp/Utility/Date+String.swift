//
//  Date+String.swift
//  NewsApp
//
//  Created by Puneeth SB on 21/04/22.
//

import Foundation

extension Date {
    /// Method to convert Date to String
    /// - Returns: Represents `String`
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppContant.dateFormat
        return dateFormatter.string(from: self)
    }
}
