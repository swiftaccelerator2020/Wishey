//
//  ATableViewCell.swift
//  autolayout'
//
//  Created by Joe Wong on 25/1/21.
//

import UIKit

class ATableViewCell: UITableViewCell {

    @IBOutlet weak var Label1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
