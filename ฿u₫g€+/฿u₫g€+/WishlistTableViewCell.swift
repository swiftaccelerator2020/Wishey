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
    @IBOutlet weak var progressBar: UIProgressView!
//    var myIndexPath: IndexPath!
    //    var currentSavings: Double!
    @IBOutlet weak var progressAnimated: PlainHorizontalProgressBar!
    @IBOutlet weak var wishlistEmptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wishlistEmptyLabel.adjustsFontSizeToFitWidth = true
        progressAnimated.color = /*UIColor(hex: 0x83DB97)*/ UIColor.systemGreen
        // Initialization code
        wishlistItemTitle.adjustsFontSizeToFitWidth = true
        wishlistItemCategory.adjustsFontSizeToFitWidth = true
        savingsOutOfPrice.adjustsFontSizeToFitWidth = true
        monthlyTarget.adjustsFontSizeToFitWidth = true
        progressBar.transform = CGAffineTransform(scaleX: self.frame.width / progressBar.frame.width, y: self.frame.height / progressBar.frame.height)
        progressBar.isHidden = true
        progressBar.sizeToFit()
//        self.autoresizesSubviews = true
//        self.contentMode = .scaleAspectFill
//        self.contentView.layoutIfNeeded()
//        if currentSavings >= Double(wishlist[myIndexPath.row].price) {
//            UIView.animate(withDuration: 4){
//                self.progressBar.setProgress(1, animated: true)
//            }
//        } else {
//            if currentSavings > 0 {
//                print(Double(currentSavings)/Double(wishlist[myIndexPath.row].price))
//                print(Double(currentSavings/Double(wishlist[myIndexPath.row].price)))
//                if currentSavings.truncatingRemainder(dividingBy: 1) != 0 {
//                    UIView.animate(withDuration: 0.5){ [self] in
//                        self.progressBar.setProgress(Float(Double(currentSavings)/Double(wishlist[myIndexPath.row].price)), animated: true)
//                    }
//                } else {
//                    UIView.animate(withDuration: 0.5){ [self] in
//                        self.progressBar.setProgress(Float(Int(currentSavings)/wishlist[myIndexPath.row].price), animated: true)
//                    }
//                }
//            }
//            else {
//                self.progressBar.setProgress(0, animated: false)
//            }
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        progressBar.sizeToFit()
//        self.autoresizesSubviews = true
//        self.contentMode = .scaleAspectFill
//        self.layoutSubviews()
//        self.contentView.layoutIfNeeded()
        // Configure the view for the selected state
//        accessoryType = selected ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
    }

}

