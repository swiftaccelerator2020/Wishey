//
//  expenseDetailTableViewController.swift
//  ฿u₫g€+
//
//  Created by Adam Tan on 15/12/20.
//

import UIKit

class expenseDetailTableViewController: UITableViewController {

    @IBOutlet weak var expenseNameTF: UITextField!
    @IBOutlet weak var amountSpentTF: UITextField!
    @IBOutlet weak var projectedExpensesTF: UITextField!
    var expense: expenseStruct!
    var theIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        projectedExpensesTF.keyboardType = .numberPad
        amountSpentTF.keyboardType = .decimalPad
//        amountSpentTF.text = String(format: "%.2f", EXPENSES.actualExpenses)
        expenseNameTF.layer.cornerRadius = 5
        expenseNameTF.clipsToBounds = true
        amountSpentTF.layer.cornerRadius = 5
        amountSpentTF.clipsToBounds = true
        projectedExpensesTF.layer.cornerRadius = 5
        projectedExpensesTF.clipsToBounds = true    
        expenseNameTF.text = expense.categoryName
        amountSpentTF.text = String(expense.actualExpenses)
        projectedExpensesTF.text = String(expense.projectedExpenses)
        
        self.hideKeyboardWhenTappedAround()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountSpentTF {
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
        let invalidCharacters =
          CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if expenseNameTF.text != nil && amountSpentTF.text != nil && projectedExpensesTF.text != nil {
            if Double(amountSpentTF.text!) != nil && Int(projectedExpensesTF.text!) != nil {
                expensesArray[theIndexPath.row]  = expenseStruct(categoryName: expenseNameTF.text!, projectedExpenses: Int(Double(amountSpentTF.text!)!), actualExpenses: Double(Int(projectedExpensesTF.text!)!))
//                dismiss(animated: true, completion: nil)
                print(expensesArray)
                performSegue(withIdentifier: "unwindSegue", sender: nil)
            } else {
//                print("cost or duration is not a number/int")
                let alert = UIAlertController(title: "Warning", message: "Cost or duration is not a whole number", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Warning", message: "Not all required text fields are filled up", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
