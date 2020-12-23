//
//  ProjectedExpensesTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//
import UIKit

class ProjectedExpensesTableViewController: UITableViewController, CustomCellUpdater {
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
//        updateForCurrentMonth()
        if UserDefaults.standard.string(forKey: "lastRecordedMonth") != nil {

    //        if Date().monthAsString() != UserDefaults.standard.string(forKey: "lastRecordedMonth") {
    //            if expenseStruct.loadFromFile() != nil {
    //                for i in expensesArray {
    //                    i.actualExpenses = 0
    //                }
    //                expenseStruct.saveToFile(expense: expensesArray)
    //                alltimeSavings += savings
    //                savings = 0
    //            }
    ////            UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
    //        }
            if Date().monthAsString() != UserDefaults.standard.string(forKey: "lastRecordedMonth") {
                UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
                if expenseStruct.loadFromFile() != nil {
                    for i in expensesArray {
                        i.actualExpenses = 0
                    }
                    expenseStruct.saveToFile(expense: expensesArray)
                    totalsavings += savings
                    savings = 0
                    updateGlobalSavings()
                    tableView.reloadData()
                }
            }
        } else {
    //        UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
            UserDefaults.standard.setValue(Date().monthAsString(), forKey: "lastRecordedMonth")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.hidesBackButton = false
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        self.timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateSpendings), userInfo: nil, repeats: true)
        updateForCurrentMonth()
        updateProjectedSavings()
    }
    func setExpenseMoney(to value: Int, of index: Int) {
        expensesArray[index].projectedExpenses = value
        //        saveToFile(expenses: projectedExpensesArray)
        tableView.reloadData()
    }
    
    func updateTableView() {
        expenseStruct.saveToFile(expense: expensesArray)
        projectedIncome.saveToFile(income: incomeArray)
        projectedSavings.saveToFile(savings: savingsArray)
        updateProjectedSavings()
        tableView.reloadData() // you do have an outlet of tableView I assume
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return incomeArray.count
        case 1:
            return savingsArray.count
        case 2:
            if expensesArray.count > 0 {
                return expensesArray.count
            }
            return 1
        default:
            return 0
        }
    }
    @IBAction func addButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "addCategory3", sender: nil)
    }
    
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        let button = UIButton()
//        button.frame = CGRect(x: 100, y: 100, width: 120, height: 50)
//        if section == 0 {
//            button.frame.origin = CGPoint(x: 290, y: 0)
//        } else if section == 2 {
//            button.frame.origin = CGPoint(x: 290, y: -20)
//        }
//        button.setTitle("+", for: .normal)
//        button.titleLabel?.font =  UIFont(name: "Helvetica Neue", size: 40)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        view.addSubview(button)
//        return view
//    }
//    @objc func buttonAction(sender: UIButton!) {
//        let btnsendtag: UIButton = sender
//        if btnsendtag.tag == 0 {
//            let alert = UIAlertController(title: "Button Pressed", message: "It works", preferredStyle: .alert)
//            present(alert, animated: true)
//            dismiss(animated: true, completion: nil)
//        }
        
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expensesArray.count <= 0 && indexPath.section == 2 {
            return 160
        }
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectedExpensesIdentifier", for: indexPath) as! ProjectedExpensesTableViewCell
        cell.tableViewController = self
        // Configure the cell...
        cell.selectionStyle = .none
        cell.delegate = self
        cell.theIndexPath = indexPath
        
        if indexPath.section == 0 {
            print(incomeArray)
            if indexPath.row < incomeArray.count {
                cell.income = incomeArray[indexPath.row]
                cell.incomeSetUp()
                cell.isUserInteractionEnabled = true
                if indexPath.row != 0 {
                    cell.incomeMoney.isEnabled = false
                } else {
                    cell.incomeMoney.isEnabled = true
                }
//                if indexPath.row != 0 && indexPath.row != incomeArray.count-1 {
//                    cell.isUserInteractionEnabled = true
//                }
            }
        } else if indexPath.section == 1 {
            print(savingsArray)
            cell.saving = savingsArray[indexPath.row]
            cell.savingsSetUp()
            if indexPath.row == 0 {
                cell.isUserInteractionEnabled = false
            } else {
                cell.isUserInteractionEnabled = true
            }
            if savingsArray[indexPath.row].savingsMoney < 0 {
                let alert = UIAlertController(title: "Warning", message: "Projected Savings is less than $0", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Change to Default", style: .default, handler: {_ in
                
            }))
                present(alert, animated: true, completion: nil)
            }
        } else if indexPath.section == 2 {
//            cell.accessoryType = .disclosureIndicator
            cell.isUserInteractionEnabled = true
            if expensesArray.count > 0 {
                cell.expense = expensesArray[indexPath.row]
                cell.expenseSetUp()
            } else {
                cell.expenseNoneSetup()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if expensesArray.count > 0 {
            if indexPath.section == 0 {
                if indexPath.row != 0 && indexPath.row != incomeArray.count-1 {
                    self.performSegue(withIdentifier: "seeOtherIncome", sender: nil)
                }
            } else if indexPath.section == 2 {
                performSegue(withIdentifier: "seeProjExpDetails", sender: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Income"
        case 1:
            return "Projected Savings"
        case 2:
            return "Projected Expenses"
        default:
            return ""
        }
    }
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
        if indexPath.section == 2 && expensesArray.count > 0 {
            return true
        }
        return false
     }
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if indexPath.section == 2 {
        if expensesArray.count > 0 {
            if editingStyle == .delete {
               // Delete the row from the data source
                let alert = UIAlertController(title: "Are you sure you want to delete \(expensesArray[indexPath.row].categoryName)?", message: "This action cannot be undone", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                    // Add
                    expensesArray.remove(at: indexPath.row)
                    expenseStruct.saveToFile(expense: expensesArray)
//                    tableView.deleteRows(at: [indexPath], with: .fade)
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
     }
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if expensesArray.count > 0 {
        if fromIndexPath.section == 2 {
            if to.section == 2 {
                if to.row != fromIndexPath.row {
                    let expense = expensesArray.remove(at: fromIndexPath.row)
                    expensesArray.insert(expense, at: to.row)
                    expenseStruct.saveToFile(expense: expensesArray)
                    tableView.reloadData()
                }
            } else {
                tableView.reloadData()
            }
        } else {
            tableView.reloadData()
        }
        }
     }
     
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 2 && expensesArray.count > 0 {
            let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                let alert = UIAlertController(title: "Are you sure you want to delete \(expensesArray[indexPath.row].categoryName)?", message: "This action cannot be undone", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                    // Add
                    expensesArray.remove(at: indexPath.row)
                    expenseStruct.saveToFile(expense: expensesArray)
//                    tableView.deleteRows(at: [indexPath], with: .fade)
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
                self.performSegue(withIdentifier: "seeProjExpDetails", sender: nil)
            }
            edit.backgroundColor = .systemBlue
            let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
            return swipeActions
        }
        return nil
    }
    
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
        if indexPath.section == 2 && expensesArray.count > 0 {
            return true
        }
        return false
     }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "seeOtherIncome" {
            
        } else if segue.identifier == "seeProjExpDetails" {
            let destVC = segue.destination as? ExpenseDetailTableViewController
            if indexPath == nil {
                indexPath = tableView.indexPathForSelectedRow
            }
            destVC?.theIndexPath = indexPath
        }
     }
    
}
