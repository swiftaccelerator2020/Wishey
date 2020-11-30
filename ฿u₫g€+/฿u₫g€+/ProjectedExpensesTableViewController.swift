//
//  ProjectedExpensesTableViewController.swift
//  ฿u₫g€+
//
//  Created by Joe Wong on 30/11/20.
//

import UIKit

class ProjectedExpensesTableViewController: UITableViewController {
    
    struct projectedExpenses {
        var incomeName: String?
        var incomeMoney: Int?
        var expenseName: String?
        var expenseMoney: Int?
    }
    
    var projectedExpensesArray = [projectedExpenses(incomeName: "Salary",incomeMoney: 3400), projectedExpenses(incomeName: "Other",incomeMoney: 6), projectedExpenses(incomeName: "Savings",incomeMoney: 3324),projectedExpenses(expenseName: "Food",expenseMoney: 30),projectedExpenses(expenseName: "Transport",expenseMoney: 20),projectedExpenses(expenseName: "Healthcare",expenseMoney: 20),projectedExpenses(expenseName: "Entertainment",expenseMoney: 12)]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectedExpensesIdentifier", for: indexPath)

        // Configure the cell...
        if let cell = cell as? ProjectedExpensesTableViewCell {
            if indexPath.section == 0 {
                cell.expenseStepper.isHidden = true
                if projectedExpensesArray[indexPath.row].incomeName != nil {
                    cell.expenseName.text = projectedExpensesArray[indexPath.row].incomeName
                }
                if projectedExpensesArray[indexPath.row].incomeMoney != nil {
                    cell.expenseMoney.text = "$" + String( projectedExpensesArray[indexPath.row].incomeMoney!)
                }
                
            } else if indexPath.section == 1 {
                cell.expenseStepper.isHidden = false
                if projectedExpensesArray[indexPath.row+3].expenseName != nil {
                    cell.expenseName.text = projectedExpensesArray[indexPath.row+3].expenseName
                }
                if projectedExpensesArray[indexPath.row+3].expenseMoney != nil {
                    cell.expenseMoney.text = "$" + String( projectedExpensesArray[indexPath.row+3].expenseMoney!)
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Income"
        case 1:
            return "Expenses"
        default:
            return ""
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
