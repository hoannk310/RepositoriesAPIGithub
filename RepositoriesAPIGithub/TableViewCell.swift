//
//  TableViewCell.swift
//  RepositoriesAPIGithub
//
//  Created by Apple on 10/2/1942 Saka.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblBranch: UILabel!
    @IBOutlet weak var lblType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
