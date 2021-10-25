//
//  HomeViewController.swift
//  News
//
//  Created by Bayu Yasaputro on 11/10/21.
//

import UIKit
import Kingfisher

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
        tableView.delegate = self
        
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
        NewsProvider.shared.loadNews { response in
            switch response {
            case .success(let news):
                self.news = news
                self.tableView.reloadData()
                
            case .failure(let error):
                print("Error load news: \(error.localizedDescription)")
            }
        }
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
            cell.tagsLabel.text = ["\(berita.publishedDate.string(format: "MMM d, yyyy"))", berita.section].joined(separator: " • ")
            let urlString = berita.media.last?.mediaMetadata.last?.url ?? ""
            cell.thumbImageView.kf.setImage(with: URL(string: urlString))
            
            cell.topConstraint.constant = indexPath.row == 0 ? 20 : 10
            cell.bottomConstraint.constant = indexPath.row == news.count - 1 ? 20 : 10
            
            return cell
        }
    }
}

// MARK: - UITableViewDalegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return itemGoups[indexPath.section] == .news
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Add to Reading List"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let news = self.news[indexPath.row]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        
        NewsData.insert(news: news, context: context)
        
        appDelegate.saveContext()
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
        let urlString = news.media.last?.mediaMetadata.last?.url ?? ""
        cell.loadingView.startAnimating()
        cell.imageView.kf.setImage(with: URL(string: urlString)) { _ in
            cell.loadingView.stopAnimating()
        }
        cell.titleLabel.text = news.title
        cell.tagsLabel.text = ["\(news.publishedDate.string(format: "MMM d, yyyy"))", news.section].joined(separator: " • ")
        
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
