//
//  NotificationViewController.swift
//  News
//
//  Created by RATAMATE on 14/10/21.
//

import UIKit

class NotificationViewController: UIViewController  {

    @IBOutlet weak var tableview: UITableView!
    weak var collectionView: UICollectionView?
    
    let headers = ["Article for you", "Today"]
    
    let articles = [News(
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
    )]
    
    let newsTv = [
        News(
            title: "Cnn Post new news",
            summary: "",
            tags: ["from", "subscribe"],
            imageUrl: "icn_cnn"
        ),
        News(
            title: "football news",
            summary: "",
            tags: ["from", "tag"],
            imageUrl: "icn_fifa"
        ),
        News(
            title: "Apple new features",
            summary: "",
            tags: ["from", "tag"],
            imageUrl: "icn_apple"
        ),
        News(
            title: "Cnn Post new news",
            summary: "",
            tags: ["from", "subscribe"],
            imageUrl: "icn_cnn"
        ),
        News(
            title: "football news",
            summary: "",
            tags: ["from", "tag"],
            imageUrl: "icn_fifa"
        ),
        News(
            title: "Apple new features",
            summary: "",
            tags: ["from", "tag"],
            imageUrl: "icn_apple"
        ),
        News(
            title: "Cnn Post new news",
            summary: "",
            tags: ["from", "subscribe"],
            imageUrl: "icn_cnn"
        ),
        News(
            title: "football news",
            summary: "",
            tags: ["from", "tag"],
            imageUrl: "icn_fifa"
        ),
        News(
            title: "Apple new features",
            summary: "",
            tags: ["from", "tag"],
            imageUrl: "icn_apple"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
            
        
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(TableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        self.tableview.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        self.tableview.register(UINib(nibName: "BaseCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "BaseCollectionTableViewCell")
    }
}


extension NotificationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.articles.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
            cell.titleLabel.text = self.articles[indexPath.row].title
            cell.tagsLabel.text = self.articles[indexPath.row].tags.joined(separator: " • ")
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCollectionTableViewCell", for: indexPath) as! BaseCollectionTableViewCell
          
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
                        
            self.collectionView = cell.collectionView
           
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 90 * 3
        }
        return UITableView.automaticDimension
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! TableViewHeaderView
        view.titleLabel.text = self.headers[section]
        return view
    }
}

extension NotificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsTv.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.titleNewsLabel.text = self.newsTv[indexPath.item].title
        cell.tagsLabel.text = self.newsTv[indexPath.item].tags.joined(separator: " ")
        cell.newsImage.image = UIImage(named: self.newsTv[indexPath.item].imageUrl)
        return cell
    }
}

extension NotificationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width , height: 90)
    }
}
