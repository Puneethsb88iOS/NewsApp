//
//  WebViewTableViewCell.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit
import WebKit

class WebViewTableViewCell: UITableViewCell {
    @IBOutlet weak var webView: WKWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
