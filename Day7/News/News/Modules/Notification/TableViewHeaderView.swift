//
//  TableViewHeaderView.swift
//  News
//
//  Created by RATAMATE on 14/10/21.
//

import UIKit

class TableViewHeaderView: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let moreLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.moreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(self.titleLabel)
        contentView.addSubview(self.moreLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            self.moreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            self.moreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        self.moreLabel.text = "SEE ALL"
        self.moreLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    }


}
