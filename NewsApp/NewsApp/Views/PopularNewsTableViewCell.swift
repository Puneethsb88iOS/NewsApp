//
//  PopularNewsTableViewCell.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit

class PopularNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsIcon: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSubTitle: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
        newsIcon.image = nil
    }
}

