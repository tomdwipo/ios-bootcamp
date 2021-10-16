//
//  HomeViewController.swift
//  News
//
//  Created by Bayu Yasaputro on 11/10/21.
//

import UIKit

enum HomeItemGroup {
    case covid
    case topsNews
    case news
}

struct NewsModel {
    let title: String
    let tag: String
    let image: String
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var itemGoups: [HomeItemGroup] = [.covid, .topsNews, .news]
    
    var covidNews: [Any] = [1]
    var topNews: [Any] = [1]
    var news: [NewsModel] = [
        NewsModel(title: "(Update) Iphone 13 Rumor New Design?", tag: "3 Hours • Architecture", image: "dummy_image"),
        NewsModel(title: "Best time to see Sunset", tag: "3 Hours • Tips & trick", image: "dummy_image")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        
        let button = UIButton(type: .system)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        button.addTarget(self, action: #selector(self.profileButtonTapped(_:)), for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barItem
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        print("Profile button tapped")
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemGoups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = itemGoups[section]
        switch group {
        case .covid:
            return covidNews.count
        case .topsNews:
            return topNews.count
        case .news:
            return news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = itemGoups[indexPath.section]
        if group == .covid {
            let cell = tableView.dequeueReusableCell(withIdentifier: "covid_cell", for: indexPath) as! CovidNewsViewCell
            
            let attText = NSMutableAttributedString(
                string: "Covid-19 News : ",
                attributes: [
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold),
                    NSAttributedString.Key.foregroundColor : UIColor(hex: "0077B6")
                ]
            )
            attText.append(NSAttributedString(
                string: "See the latest coverage about Covid-19",
                attributes:  [
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular),
                    NSAttributedString.Key.foregroundColor : UIColor(hex: "7F7F7F")
                ]
            ))
            
            cell.titleLabel.attributedText = attText
            
            cell.topConstraint.constant = indexPath.row == 0 ? 20 : 10
            cell.bottomConstraint.constant = indexPath.row == covidNews.count - 1 ? 20 : 10
            
            return cell
        }
        
        if group == .topsNews { //if group == .topNews {
            let cell = tableView.dequeueReusableCell(withIdentifier: "top_news_cell", for: indexPath) as! TopNewsViewCell
            
            cell.titleLabel.text = "News for you"
            cell.subtitleLabel.text = "Top 5 News of the day"
            cell.newsImageView.image = UIImage(named: "dummy_image")
            cell.descLabel.text = "Dream home design inspiration for you in the future."
            cell.tagsLabel.text = "3 Hours • Architecture"
            
            cell.topConstraint.constant = indexPath.row == 0 ? 20 : 10
            cell.bottomConstraint.constant = indexPath.row == topNews.count - 1 ? 20 : 10
            
            return cell
        }
        if group == .news { // .news
            let cell = tableView.dequeueReusableCell(withIdentifier: "bottom_news_cell", for: indexPath) as! BottomNewsViewCell
            
            cell.titleLabel.text = self.news[indexPath.row].title
            cell.newsImageView.image = UIImage(named: self.news[indexPath.row].image)
            cell.tagsLabel.text = self.news[indexPath.row].tag
            
            cell.topConstraint.constant = indexPath.row == 0 ? 20 : 10
            cell.bottomConstraint.constant = indexPath.row == news.count - 1 ? 20 : 10
            
            return cell
        }
        return UITableViewCell()
    }
}
