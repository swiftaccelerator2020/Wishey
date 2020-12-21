//
//  AddExpensesTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 6/12/20.
//

import UIKit

class AddExpensesTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var budgetAmount: UITextField!
    @IBOutlet weak var categoryAmount: UITextField!
    @IBOutlet weak var amtSpent: UILabel!
    @IBOutlet var cells: [UITableViewCell]!
    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var stepper: UIStepper!
//    var sourceViewController: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        amtSpent.adjustsFontSizeToFitWidth = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.hideKeyboardWhenTappedAround()
        categoryAmount.delegate = self
        categoryAmount.keyboardType = .decimalPad
        budgetAmount.delegate = self
        budgetAmount.keyboardType = .numberPad
        for i in cells {
            i.selectionStyle = .none
        }
        categoryAmount.layer.cornerRadius = 5
        categoryAmount.clipsToBounds = true
        categoryName.layer.cornerRadius = 5
        categoryName.clipsToBounds = true
        budgetAmount.layer.cornerRadius = 5
        budgetAmount.clipsToBounds = true
        done.isEnabled = false
//        if Int(budgetAmount.text!) != nil && !budgetAmount.text!.isEmpty && budgetAmount.text != nil {
//            stepper.value = Double(budgetAmount.text!)!
//        } else {
//            stepper.value = 0
//            budgetAmount.text = String(Int(stepper.value))
//        }
        stepper.value = 100
        print(stepper.value)
        budgetAmount.text = String(Int(stepper.value))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == categoryAmount {
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
    @IBAction func steppervaluechange(_ sender: Any) {
        budgetAmount.text = String(Int(stepper.value))
        print(stepper.value)
        checkAndHighlightErrors()
    }
    
    func checkAndHighlightErrors() {
        if categoryName.text != nil && !categoryName.text!.isEmpty && budgetAmount.text != nil && !budgetAmount.text!.isEmpty && categoryAmount.text != nil && !categoryAmount.text!.isEmpty {
            if Double(categoryAmount.text!) != nil && Int(budgetAmount.text!) != nil && Int(budgetAmount.text!)! > 0 {
                done.isEnabled = true
                categoryName.layer.borderWidth = 0
                budgetAmount.layer.borderWidth = 0
                categoryAmount.layer.borderWidth = 0
                categoryName.layer.borderColor = .none
                budgetAmount.layer.borderColor = .none
                categoryAmount.layer.borderColor = .none
            } else if Int(budgetAmount.text!) == nil {
                budgetAmount.layer.borderWidth = 1
                budgetAmount.layer.borderColor = UIColor.systemYellow.cgColor
            } else if Int(budgetAmount.text!)! <= 0 {
                budgetAmount.layer.borderWidth = 1
                budgetAmount.layer.borderColor = UIColor.systemOrange.cgColor
            } else if Double(categoryAmount.text!) == nil {
                categoryAmount.layer.borderWidth = 1
                categoryAmount.layer.borderColor = UIColor.systemYellow.cgColor
            } else if Double(categoryAmount.text!)! <= 0.0 {
                categoryAmount.layer.borderWidth = 1
                categoryAmount.layer.borderColor = UIColor.systemOrange.cgColor
            }

        } else {
            if categoryName.text == nil || categoryName.text!.isEmpty {
                categoryName.layer.borderWidth = 1
                categoryName.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                categoryName.layer.borderWidth = 0
                categoryName.layer.borderColor = .none
            }
            if budgetAmount.text == nil || budgetAmount.text!.isEmpty {
                budgetAmount.layer.borderWidth = 1
                budgetAmount.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                budgetAmount.layer.borderWidth = 0
                budgetAmount.backgroundColor = .none
            }
            if categoryAmount.text == nil || categoryAmount.text!.isEmpty {
                categoryAmount.layer.borderWidth = 1
                categoryAmount.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                categoryAmount.layer.borderWidth = 0
                categoryAmount.backgroundColor = .none
            }
        }
    }
    
    @IBAction func catEdited(_ sender: Any) {
        if Int(budgetAmount.text!) != nil && !budgetAmount.text!.isEmpty && budgetAmount.text != nil {
            stepper.value = Double(budgetAmount.text!)!
        } else {
            stepper.value = 100
            budgetAmount.text = String(Int(stepper.value))
        }
        checkAndHighlightErrors()
    }
//    @IBAction func budgetEdited(_ sender: Any) {
//        if budgetAmount.text != nil && !budgetAmount.text!.isEmpty {
//            budgetAmount.layer.borderWidth = 0
//        } else {
//            if budgetAmount.text == nil || budgetAmount.text!.isEmpty {
//                budgetAmount.layer.borderWidth = 1
//                budgetAmount.layer.borderColor = UIColor.systemRed.cgColor
//            } else if Int(budgetAmount.text!) == nil {
//                budgetAmount.layer.borderWidth = 1
//                budgetAmount.layer.borderColor = UIColor.systemRed.cgColor
//            } else if Int(budgetAmount.text!)! <= 0 {
//                budgetAmount.layer.borderWidth = 1
//                budgetAmount.layer.borderColor = UIColor.systemOrange.cgColor
//            } else {
//                budgetAmount.layer.borderWidth = 0
//                budgetAmount.backgroundColor = .none
//            }
//        }
//    }
//    @IBAction func catAmountEdited(_ sender: Any) {
//        if categoryAmount.text != nil && !categoryAmount.text!.isEmpty{
//            categoryAmount.layer.borderWidth = 0
//        } else {
//            if Double(categoryAmount.text!)! <= 0.0 {
//                categoryAmount.layer.borderWidth = 1
//                categoryAmount.layer.borderColor = UIColor.systemOrange.cgColor
//            } else {
//                categoryAmount.layer.borderWidth = 0
//                categoryAmount.backgroundColor = .none
//            }
//        }
//    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        if categoryName.text != nil && !categoryName.text!.isEmpty && categoryAmount.text != nil && !categoryAmount.text!.isEmpty && budgetAmount.text != nil && !budgetAmount.text!.isEmpty {
            if Double(categoryAmount.text!) != nil && Int(budgetAmount.text!) != nil && Int(budgetAmount.text!)! > 0 {
                expensesArray.append(expenseStruct(categoryName: categoryName.text!, projectedExpenses: Int(budgetAmount.text!)!, actualExpenses: Double(categoryAmount.text!)!))
                expenseStruct.saveToFile(expense: expensesArray)
                updateGlobalSavings()
                view.endEditing(true)
//                if sourceViewController == ViewController {
                performSegue(withIdentifier: "unwindHome", sender: nil)
//                } else if sourceViewController == exp {
//                    performSegue(withIdentifier: "addUnwindExpense", sender: nil)
//                }
            } else {
                let alert = UIAlertController(title: "Warning", message: "Budget is not a whole number or Amount Spent is not a number", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Warning", message: "Not all required text fields are filled up", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
