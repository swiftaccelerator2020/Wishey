//
//  expensesTableViewController.swift
//  ฿u₫g€+
//
//  Created by Adam Tan on 30/11/20.
//

import UIKit

class expensesTableViewController: UITableViewController {
    
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "expensesSegue", sender: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expensesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! expenseTableViewCell
        cell.expense = expensesArray[indexPath.row]
        cell.setUp()
        cell.selectionStyle = .none
        cell.expenseName.adjustsFontSizeToFitWidth = true
        cell.spendingLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "\(Date().monthAsString()) - Expenses/Spendings"
        setupLargeTitleAutoAdjustFont()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        title = "\(Date().monthAsString()) - Expenses/Spendings"
        setupLargeTitleAutoAdjustFont()
        tableView.reloadData()
    }
    
    private lazy var setupLargeTitleLabelOnce: Void = {[unowned self] in
        if #available(iOS 11.0, *) {
            self.setupLargeTitleAutoAdjustFont()
        }
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let _ = setupLargeTitleLabelOnce
    }
    func setupLargeTitleAutoAdjustFont() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        // recursively find the label
        func findLabel(in view: UIView) -> UILabel? {
            if view.subviews.count > 0 {
                for subview in view.subviews {
                    if let label = findLabel(in: subview) {
                        return label
                    }
                }
            }
            return view as? UILabel
        }

        if let label = findLabel(in: navigationBar) {
            if label.text == self.title {
                label.adjustsFontSizeToFitWidth = true
                // label.minimumScaleFactor = 0.7
            }
            //label.numberOfLines = 2
        }
    }
    
    @IBAction func unwindToExpense( _ seg: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
            expensesArray.remove(at: indexPath.row)
            expenseStruct.saveToFile(expense: expensesArray)
            tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let expense = expensesArray.remove(at: fromIndexPath.row)
        expensesArray.insert(expense, at: to.row)
        expenseStruct.saveToFile(expense: expensesArray)
        tableView.reloadData()
     }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            expensesArray.remove(at: indexPath.row)
            expenseStruct.saveToFile(expense: expensesArray)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        let edit = UIContextualAction(style: .destructive, title: "Edit") {  (contextualAction, view, boolValue) in
            self.indexPath = indexPath
            self.performSegue(withIdentifier: "expensesSegue", sender: nil)
        }
        edit.backgroundColor = .systemBlue
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeActions
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "expensesSegue" {
            let destVC = segue.destination as? ExpenseDetailTableViewController
            if indexPath == nil {
                indexPath = tableView.indexPathForSelectedRow
            }
            destVC?.theIndexPath = indexPath
        } else if segue.identifier == "addCategory2" {
            let destVC = segue.destination as? AddExpensesTableViewController
//            destVC?.sourceViewController = expensesTableViewController
        }
     }
    
    @IBAction func addExpensesCategory(_ sender: Any) {
        performSegue(withIdentifier: "addCategory2", sender: nil)
    }
    
}
