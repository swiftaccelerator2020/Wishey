//
//  expensesTableViewController.swift
//  ฿u₫g€+
//
//  Created by Adam Tan on 30/11/20.
//

import UIKit

class expensesTableViewController: UITableViewController {
    
    var indexPath: IndexPath!
    var timer: Timer?
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.timer != nil
        {
           self.timer!.invalidate()
           self.timer = nil
        }
        indexPath = nil
    }
    
    @objc func updateSpendings() {
        updateForCurrentMonth()
//        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "expensesSegue", sender: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return expensesArray.count
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! expenseTableViewCell
        if indexPath.section == 0 {
            cell.expense = expensesArray[indexPath.row]
            cell.setUp()
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.spendingLabel.text = "$\(String(format: "%.2f", savings)) saved"
            cell.expenseName.text = "Savings"
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
        cell.expenseName.adjustsFontSizeToFitWidth = true
        cell.spendingLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 30
//        }
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Expenses/Spendings"
        } else {
            return "Savings"
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateSpendings), userInfo: nil, repeats: true)
        title = "\(Date().monthAsString())"
        setupLargeTitleAutoAdjustFont()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        title = "\(Date().monthAsString())"
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
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        return false
     }
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
            let alert = UIAlertController(title: "Are you sure you want to delete \(expensesArray[indexPath.row].categoryName)?", message: "This action cannot be undone", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                // Add
                expensesArray.remove(at: indexPath.row)
                expenseStruct.saveToFile(expense: expensesArray)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                // End
            }))
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: {_ in
                    tableView.reloadData()
                }))
            self.present(alert, animated: true, completion: nil)
            // copy below
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
        if indexPath.section == 0 {
            let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                let alert = UIAlertController(title: "Are you sure you want to delete \(expensesArray[indexPath.row].categoryName)?", message: "This action cannot be undone", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                    // Add
                    expensesArray.remove(at: indexPath.row)
                    expenseStruct.saveToFile(expense: expensesArray)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadData()
                    // End
                }))
                alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: {_ in
                    tableView.reloadData()
                }))
                self.present(alert, animated: true, completion: nil)
                // copy below
            }
            let edit = UIContextualAction(style: .destructive, title: "Edit") {  (contextualAction, view, boolValue) in
                self.indexPath = indexPath
                self.performSegue(withIdentifier: "expensesSegue", sender: nil)
            }
            edit.backgroundColor = .systemBlue
            let add = UIContextualAction(style: .destructive, title: "Add") {  (contextualAction, view, boolValue) in
                self.indexPath = indexPath
                self.performSegue(withIdentifier: "addValue", sender: nil)
            }
            add.backgroundColor = .systemPurple
            let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit, add])
            return swipeActions
        }
        return nil
    }
    
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
        if indexPath.section == 0 {
            return true
        }
        return false
     }
    
    
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
        } else if segue.identifier == "addValue" {
            let destVC = segue.destination as? AddValueTableViewController
            destVC?.theIndexPath = indexPath
        }
     }
    
    @IBAction func addExpensesCategory(_ sender: Any) {
        performSegue(withIdentifier: "addCategory2", sender: nil)
    }
    
}
