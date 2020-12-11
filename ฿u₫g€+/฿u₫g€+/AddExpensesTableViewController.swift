//
//  AddExpensesTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 6/12/20.
//

import UIKit

class AddExpensesTableViewController: UITableViewController {
    
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryAmount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    //
    //    /*
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    //
    //        // Configure the cell...
    //
    //        return cell
    //    }
    //    */
    //
    //    /*
    //    // Override to support conditional editing of the table view.
    //    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        // Return false if you do not want the specified item to be editable.
    //        return true
    //    }
    //    */
    //
    //    /*
    //    // Override to support editing the table view.
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            // Delete the row from the data source
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        } else if editingStyle == .insert {
    //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //        }
    //    }
    //    */
    //
    //    /*
    //    // Override to support rearranging the table view.
    //    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //
    //    }
    //    */
    //
    //    /*
    //    // Override to support conditional rearranging of the table view.
    //    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    //        // Return false if you do not want the item to be re-orderable.
    //        return true
    //    }
    //    */
    //
    //    /*
    //    // MARK: - Navigation
    //
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //    }
    //    */
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwind", sender: nil)
    }
    @IBAction func save(_ sender: Any) {
        if categoryName.text != nil && !categoryName.text!.isEmpty && categoryAmount.text != nil && !categoryAmount.text!.isEmpty {
            projectedExpensesArray.append(projectedExpenses(expenseName: categoryName.text!, expenseMoney: Int(categoryAmount.text!)!))
            saveToFile(expenses: projectedExpensesArray)
            
            performSegue(withIdentifier: "unwind", sender: nil)
        } else {
            let alert = UIAlertController(title: "Category name and money is not filled or amount spent on Category is not an integer", message: "", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        }
    }
}
