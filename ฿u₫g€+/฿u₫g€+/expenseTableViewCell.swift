//
//  expenseTableViewCell.swift
//  ฿u₫g€+
//
//  Created by Adam Tan on 30/11/20.
//

import UIKit

class expenseTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var spendingLabel: UILabel!
    var expense: expenseStruct!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp() {
        expenseName.text = expense.name
        spendingLabel.text = "$\(expense.actualSpending)/\(expense.projectedSpending) spent"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
