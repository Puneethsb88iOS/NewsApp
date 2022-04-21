//
//  HeaderCell.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerTitle: UILabel!
    
    func setUpHeaderCell(title: String) {
        headerTitle.text = title
    }
}
