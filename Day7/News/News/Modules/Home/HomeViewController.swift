//
//  HomeViewController.swift
//  News
//
//  Created by Bayu Yasaputro on 11/10/21.
//

import UIKit

enum HomeItemGroup {
    case covid
    case topNews
    case news
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var topNewsCollectionView: UICollectionView?
    weak var pageControl: UIPageControl?
    
    var itemGoups: [HomeItemGroup] = [.covid, .topNews, .news]
    
    var covidNews: String = "See the latest coverage about Covid-19"
    var topNews: [News] = []
    var news: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "news_cell")
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
        
        loadTopNews()
        loadNews()
    }
    
    // MARK: - Helpers
    func loadTopNews() {
        topNews = [
            News(
                title: "(Update) Iphone 13 Rumor New design?",
                summary: "",
                tags: ["7 Hours", "Tech"],
                imageUrl: "dummy_image"
            ),
            News(
                title: "Dream home design inspiration for you in the future.",
                summary: "",
                tags: ["2 Hours", "Architecture"],
                imageUrl: "dummy_image_2"
            ),
            News(
                title: "YouTube's new features, let's take a look.",
                summary: "",
                tags: ["3 Hours", "Tech"],
                imageUrl: "dummy_image_3"
            )
        ]
    }
    
    func loadNews() {
        news = [
            News(
                title: "(Update) Iphone 13 Rumor New design?",
                summary: "",
                tags: ["7 Hours", "Tech"],
                imageUrl: "dummy_image"
            ),
            News(
                title: "Dream home design inspiration for you in the future.",
                summary: "",
                tags: ["2 Hours", "Architecture"],
                imageUrl: "dummy_image_2"
            ),
            News(
                title: "YouTube's new features, let's take a look.",
                summary: "",
                tags: ["3 Hours", "Tech"],
                imageUrl: "dummy_image_3"
            )
        ]
    }
    
    // MARK: - Actions
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
            return 1
        case .topNews:
            return 1
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
                string: covidNews,
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
        else if group == .topNews {
            let cell = tableView.dequeueReusableCell(withIdentifier: "top_news_cell", for: indexPath) as! TopNewsViewCell
            
            cell.titleLabel.text = "News for you"
            cell.subtitleLabel.text = "Top \(topNews.count) News of the day"
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            self.topNewsCollectionView = cell.collectionView
            
            cell.pageControl.currentPage = 0
            self.pageControl = cell.pageControl
            
            return cell
        }
        else { // .news
            let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell", for: indexPath) as! NewsViewCell
            
            let berita = news[indexPath.row]
            cell.titleLabel.text = berita.title
            cell.tagsLabel.text = berita.tags.joined(separator: " • ")
            cell.thumbImageView.image = UIImage(named: berita.imageUrl)
            
            
            cell.topConstraint.constant = indexPath.row == 0 ? 20 : 10
            cell.bottomConstraint.constant = indexPath.row == news.count - 1 ? 20 : 10
            
            return cell
        }
    }
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "top_news_cell", for: indexPath) as! TopNewsCollectionViewCell
        
        let news = topNews[indexPath.item]
        cell.imageView.image = UIImage(named: news.imageUrl)
        cell.titleLabel.text = news.title
        cell.tagsLabel.text = news.tags.joined(separator: " • ")
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 265)
    }
    
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.topNewsCollectionView {
            let page = scrollView.contentOffset.x / scrollView.frame.width
            pageControl?.currentPage = Int(page)
        }
    }
}
