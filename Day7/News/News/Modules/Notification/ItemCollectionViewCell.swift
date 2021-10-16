//
//  ItemCollectionViewCell.swift
//  News
//
//  Created by RATAMATE on 15/10/21.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
