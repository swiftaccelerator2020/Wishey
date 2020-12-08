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
    @IBOutlet weak var incomeMoney: UILabel!
    @IBOutlet weak var incomeName: UILabel!
    @IBOutlet weak var expenseName: UILabel!
    
    var income: projectedIncome!
    var expense: projectedExpenses!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func incomeSetUp() {
        incomeName.isHidden = false
        incomeMoney.isHidden = false
        expenseName.isHidden = true
        expenseMoney.isHidden = true
        expenseStepper.isHidden = true
        incomeName.text = income.incomeName
        print(income.incomeName)
        incomeMoney.text = "$" + String(income.incomeMoney)
    }
    
    func expenseSetUp() {
        expenseStepper.value = Double(expense.expenseMoney)
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = false
        expenseMoney.isHidden = false
        expenseStepper.isHidden = false
        expenseName.text = expense.expenseName
        expenseMoney.text = "$" + String(expense.expenseMoney)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        expense.expenseMoney = Int(expenseStepper.value)
        expenseSetUp()
    }
    
}
