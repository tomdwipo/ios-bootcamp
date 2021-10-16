//
//  BaseCollectionTableViewCell.swift
//  News
//
//  Created by RATAMATE on 15/10/21.
//

import UIKit

class BaseCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")

       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
