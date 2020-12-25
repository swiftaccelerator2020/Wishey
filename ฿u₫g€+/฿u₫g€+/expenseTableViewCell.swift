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
    @IBOutlet weak var epitomeOfEmptiness: UILabel!
    var expense: expenseStruct!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp() {
        epitomeOfEmptiness.isHidden = true
        expenseName.isHidden = false
        spendingLabel.isHidden = false
        expenseName.text = expense.categoryName
        spendingLabel.text = "$\(currencyFormatter.string(from: NSNumber(value: Double(expense.actualExpenses)))!)/\(expense.projectedExpenses) spent"
        if expense.actualExpenses > Double(expense.projectedExpenses) {
            spendingLabel.textColor = .systemRed
        } else {
            spendingLabel.textColor = .label
        }
    }
    func emptySetUp(){
        epitomeOfEmptiness.isHidden = false
        expenseName.isHidden = true
        spendingLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
