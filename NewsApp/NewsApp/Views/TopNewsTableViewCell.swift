//
//  TopNewsTableViewCell.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit

class TopNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
