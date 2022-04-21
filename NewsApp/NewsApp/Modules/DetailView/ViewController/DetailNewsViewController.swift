//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit
import WebKit
class DetailNewsViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var detailTableView: UITableView!
    var viewModel: DetailNewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }
    
    private func updateDisplay() {
        detailTableView.register(UINib(nibName: "PopularNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularNewsTableViewCell")
        detailTableView.register(UINib(nibName: "WebViewTableViewCell", bundle: nil), forCellReuseIdentifier: "WebViewTableViewCell")
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension DetailNewsViewController: UITableViewDelegate, UITableViewDataSource  {
    
    /// method for set numberOfSections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.newsDataModel.articles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// method for set heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.frame.height*0.75
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell
        if section == 1 {
            cell?.setUpHeaderCell(title: "Popular News")
            return cell
        }
        return UIView()
        
    }
    /// method for set cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let webviewCell = (tableView.dequeueReusableCell(withIdentifier: "WebViewTableViewCell") as? WebViewTableViewCell) else {
                return UITableViewCell()
            }
            webviewCell.selectionStyle = .none
            webviewCell.webView.navigationDelegate = self
            guard let url = URL(string: viewModel.webUrl) else { return UITableViewCell() }
            webviewCell.webView.load(URLRequest(url: url))
            webviewCell.webView.allowsBackForwardNavigationGestures = true
            return webviewCell
        }
        if indexPath.section == 1 {
            guard let popularNewsCell: PopularNewsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PopularNewsTableViewCell") as? PopularNewsTableViewCell) else {
                return UITableViewCell()
            }
            popularNewsCell.tag = indexPath.row
            DispatchQueue.global().async { [weak self] in
                guard let weakSelf = self else { return }
                if let urlImage = weakSelf.viewModel.newsDataModel.articles[indexPath.row].urlToImage, let url = URL(string: urlImage) {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            if popularNewsCell.tag == indexPath.row {
                                popularNewsCell.newsIcon.image = UIImage(data: data)
                            }
                        }
                    }
                }
            }
            popularNewsCell.newsTitle.text = viewModel.newsDataModel.articles[indexPath.row].title
            popularNewsCell.newsSubTitle.text = viewModel.newsDataModel.articles[indexPath.row].description
            popularNewsCell.selectionStyle = .none
            return popularNewsCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 50
    }
}
