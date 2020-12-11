//
//  ProjectedExpensesTableViewController.swift
//  ฿u₫g€+
//
//  Created by Joe Wong on 30/11/20.
//
import UIKit

class ProjectedExpensesTableViewController: UITableViewController, CustomCellUpdater {

     override func viewDidLoad() {
         super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.hideKeyboardWhenTappedAround()
    }
    
    func setExpenseMoney(to value: Int, of index: Int) {
        projectedExpensesArray[index].expenseMoney = value
        tableView.reloadData()
    }
    
    func updateTableView() {
        updateSavings()
        tableView.reloadData() // you do have an outlet of tableView I assume
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
            return projectedIncomeArray.count
        case 1:
            return projectedExpensesArray.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectedExpensesIdentifier", for: indexPath) as! ProjectedExpensesTableViewCell
        cell.tableViewController = self
        // Configure the cell...
        cell.selectionStyle = .none
        cell.delegate = self
        cell.index = indexPath.row

        if indexPath.section == 0 {
            cell.income = projectedIncomeArray[indexPath.row]
            cell.incomeSetUp()
            if indexPath.row == projectedIncomeArray.count-1 {
                cell.incomeMoney.isEnabled = false
            }
        } else if indexPath.section == 1 {
            cell.expense = projectedExpensesArray[indexPath.row]
            cell.expenseSetUp()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Income"
        case 1:
            return "Projected Expenses"
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
