//
//  WishlistTableViewCell.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

    @IBOutlet weak var wishlistItemTitle: UILabel!
    @IBOutlet weak var wishlistItemCategory: UILabel!
    @IBOutlet weak var savingsOutOfPrice: UILabel!
    @IBOutlet weak var monthlyTarget: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        wishlistItemTitle.adjustsFontSizeToFitWidth = true
        wishlistItemCategory.adjustsFontSizeToFitWidth = true
        savingsOutOfPrice.adjustsFontSizeToFitWidth = true
        monthlyTarget.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
