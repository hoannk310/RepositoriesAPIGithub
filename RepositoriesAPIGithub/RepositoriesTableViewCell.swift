//
//  RepositoriesTableViewCell.swift
//  RepositoriesAPIGithub
//
//  Created by Apple on 9/30/1942 Saka.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNameRepos: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var imgAuthor: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        imgAuthor.layer.cornerRadius = imgAuthor.frame.height/2
        imgAuthor.layer.shadowColor = UIColor.black.cgColor
        imgAuthor.layer.shadowOpacity = 1
        imgAuthor.clipsToBounds = true
        imgAuthor.layer.shadowRadius = 3.0
    }

}
