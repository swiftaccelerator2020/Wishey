//
//  AddValueTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 20/12/20.
//

import UIKit

class AddValueTableViewController: UITableViewController, UITextFieldDelegate {
    var theIndexPath: IndexPath!
    var expense: expenseStruct!
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var amtSpent: UILabel!
    @IBOutlet weak var amtToAdd: UITextField!
    @IBOutlet var cells: [UITableViewCell]!
    @IBOutlet weak var done: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        expense = expensesArray[theIndexPath.row]
        self.hideKeyboardWhenTappedAround()
        categoryName.text = expensesArray[theIndexPath.row].categoryName
        categoryName.isUserInteractionEnabled = false
        for i in cells {
            i.selectionStyle = .none
        }
        amtToAdd.delegate = self
        amtToAdd.keyboardType = .decimalPad
        amtSpent.adjustsFontSizeToFitWidth = true
        done.isEnabled = false
        categoryName.layer.borderWidth = 0
        amtToAdd.layer.borderWidth = 0
        categoryName.layer.borderColor = .none
        amtToAdd.layer.borderColor = .none
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
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
    @IBAction func hideKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func textFieldEnd(_ sender: Any) {
        if !categoryName.text!.isEmpty && categoryName.text != nil && !amtToAdd.text!.isEmpty && amtToAdd.text != nil {
            if Double(amtToAdd.text!) != nil {
                categoryName.layer.borderWidth = 0
                amtToAdd.layer.borderWidth = 0
                categoryName.layer.borderColor = .none
                amtToAdd.layer.borderColor = .none
                done.isEnabled = true
            }
        } else {
            if categoryName.text == nil || categoryName.text!.isEmpty {
                categoryName.layer.borderWidth = 1
                categoryName.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                categoryName.layer.borderWidth = 0
                categoryName.layer.borderColor = .none
            }
            if amtToAdd.text == nil || amtToAdd.text!.isEmpty {
                amtToAdd.layer.borderWidth = 1
                amtToAdd.layer.borderColor = UIColor.systemRed.cgColor
            } else if Double(amtToAdd.text!) == nil {
                amtToAdd.layer.borderWidth = 1
                amtToAdd.layer.borderColor = UIColor.systemYellow.cgColor
            } else if Double(amtToAdd.text!)! <= 0.0 {
                amtToAdd.layer.borderWidth = 1
                amtToAdd.layer.borderColor = UIColor.systemOrange.cgColor
            } else {
                amtToAdd.layer.borderWidth = 0
                amtToAdd.backgroundColor = .none
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func doneAction(_ sender: Any) {
        expensesArray[theIndexPath.row].actualExpenses += Double(amtToAdd.text!)!
        expenseStruct.saveToFile(expense: expensesArray)
        updateGlobalSavings()
        view.endEditing(true)
        performSegue(withIdentifier: "unwindAddExpense", sender: nil)
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
