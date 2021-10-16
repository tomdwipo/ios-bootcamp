//
//  BottomNewsViewCell.swift
//  News
//
//  Created by RATAMATE on 11/10/21.
//

import UIKit

class BottomNewsViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!

    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        self.newsImageView.layer.cornerRadius = 8
        self.newsImageView.layer.masksToBounds = true
    }

}
