//
//  ProjectedExpensesTableViewCell.swift
//  ฿u₫g€+
//
//  Created by Joe Wong on 30/11/20.
//

import UIKit

class ProjectedExpensesTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var expenseMoney: UILabel!
    @IBOutlet weak var expenseStepper: UIStepper!
    @IBOutlet weak var expenseName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
