//
//  HomeScreenViewController.swift
//  NewsApp
//
//  Created by Puneeth SB on 20/04/22.
//

import UIKit

class HomeScreenViewController: UITableViewController {
    
    let viewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PopularNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularNewsTableViewCell")
        tableView.register(UINib(nibName: "TopNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Firstcell")
        viewModel.getMockNewsData()
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

extension HomeScreenViewController {
    
    /// method for set numberOfSections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.newsDataModel.articles.count - 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// method for set heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 450
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = ["Top News", "Popular News"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell
        cell?.setUpHeaderCell(title: title[section])
        return cell
    }
    /// method for set cell data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let topNewsCell: TopNewsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "Firstcell") as? TopNewsTableViewCell) else {
                return UITableViewCell()
            }
            topNewsCell.topImage.loadFrom(URLAddress: viewModel.newsDataModel.articles[indexPath.section].urlToImage)
            topNewsCell.title.text = viewModel.newsDataModel.articles[indexPath.section].title
            topNewsCell.subTitle.text = viewModel.newsDataModel.articles[indexPath.section].description
            topNewsCell.selectionStyle = .none
            return topNewsCell
        }
        if indexPath.section == 1 {
            guard let popularNewsCell: PopularNewsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PopularNewsTableViewCell") as? PopularNewsTableViewCell) else {
                return UITableViewCell()
            }
            popularNewsCell.tag = indexPath.row+1
            DispatchQueue.global().async { [weak self] in
                guard let weakSelf = self else { return }
                // Fetch Image Data
                let url = URL(string: weakSelf.viewModel.newsDataModel.articles[indexPath.row+1].urlToImage)!
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        if popularNewsCell.tag == indexPath.row+1 {
                            popularNewsCell.newsIcon.image = UIImage(data: data)
                        }
                    }
                }
            }
            popularNewsCell.newsTitle.text = viewModel.newsDataModel.articles[indexPath.row+1].title
            popularNewsCell.newsSubTitle.text = viewModel.newsDataModel.articles[indexPath.row+1].description
            popularNewsCell.selectionStyle = .none
            return popularNewsCell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailNewsViewController") as? DetailNewsViewController else {
            return
        }
        switch indexPath.section {
        case 0 :
            secondViewController.viewModel = DetailNewsViewModel(url: viewModel.newsDataModel.articles[indexPath.section].url, newsModel: viewModel.newsDataModel)
        case 1:
            secondViewController.viewModel = DetailNewsViewModel(url: viewModel.newsDataModel.articles[indexPath.row+1].url, newsModel: viewModel.newsDataModel)
        default : break
        }
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        let url = URL(string: URLAddress)!
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    // Create Image and Update Image View
                    weakSelf.image = UIImage(data: data)
                }
            }
        }
    }
}
