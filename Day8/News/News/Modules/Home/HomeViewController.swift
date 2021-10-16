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
        NewsProvider.shared.loadTopNews { response in
            switch response {
            case .success(let news):
                self.topNews = news
                self.tableView.reloadData()
                
            case .failure(let error):
                print("Error load top news: \(error.localizedDescription)")
            }
        }
    }
    
    func loadNews() {
        
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
            cell.pageControl.numberOfPages = topNews.count
            self.pageControl = cell.pageControl
            
            return cell
        }
        else { // .news
            let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell", for: indexPath) as! NewsViewCell
            
            let berita = news[indexPath.row]
            cell.titleLabel.text = berita.title
            cell.tagsLabel.text = ["\(berita.publishedDate)", berita.section].joined(separator: " • ")
//            cell.thumbImageView.image = UIImage(named: berita.imageUrl)
            
            
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
        if let imageUrl = news.media.last?.mediaMetadata.last?.url,
           let url = URL(string: imageUrl) {
            cell.loadingView.startAnimating()
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                        cell.loadingView.stopAnimating()
                    }
                }
            }
        }
        
        cell.titleLabel.text = news.title
        cell.tagsLabel.text = ["\(news.publishedDate)", news.section].joined(separator: " • ")
        
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
