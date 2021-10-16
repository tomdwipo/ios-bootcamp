//
//  TopNewsViewCell.swift
//  News
//
//  Created by Bayu Yasaputro on 11/10/21.
//

import UIKit

class TopNewsViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        newsImageView.layer.cornerRadius = 8
        newsImageView.layer.masksToBounds = true
    }

}
