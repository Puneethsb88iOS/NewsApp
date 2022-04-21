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
    @IBOutlet weak var ndTV: UIButton!
    @IBOutlet weak var ndBookMark: UIButton!
    private var imageRequest: Cancellable?
    override func awakeFromNib() {
        super.awakeFromNib()
        ndTV.layer.cornerRadius = 15.0
        ndBookMark.layer.cornerRadius = 17.0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsIcon.image = nil
        imageRequest?.cancel()
    }
    
}

protocol Cancellable {

    // MARK: - Methods

    func cancel()

}

extension URLSessionTask: Cancellable {

}
