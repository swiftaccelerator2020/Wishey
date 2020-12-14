//
//  AddWishlistTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 6/12/20.
//

import UIKit

class AddWishlistTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameCategoryField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet var cells: [UITableViewCell]!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var pickerView2 = UIPickerView()
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == costField {
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self,  selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self,  selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//        self.nameField.delegate = self
        durationField.delegate = self
        durationField.keyboardType = .numberPad
        costField.delegate = self
        costField.keyboardType = .decimalPad
        nameCategoryField.inputView = pickerView2
        nameCategoryField.tintColor = .none
        pickerView2.dataSource = self
        pickerView2.delegate = self
        for i in cells {
            i.selectionStyle = .none
        }
        doneButton.isEnabled = false
        nameField.layer.cornerRadius = 5
        nameField.clipsToBounds = true
        nameCategoryField.layer.cornerRadius = 5
        nameCategoryField.clipsToBounds = true
        costField.layer.cornerRadius = 5
        costField.clipsToBounds = true
        durationField.layer.cornerRadius = 5
        durationField.clipsToBounds = true
        self.hideKeyboardWhenTappedAround()
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        cell
//        cell.sel
//        return cell
//    }
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
//    @objc func keyboardWillChange(notification: Notification) {
//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
//        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
//            view.frame.origin.y = -keyboardRect.height
//        } else if notification.name == UIResponder.keyboardWillHideNotification {
//            view.frame.origin.y = 0
//        }
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: self.view.window)
//    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count+1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return ""
        } else {
            return categories[row-1]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        if row == 0 {
            let alert = UIAlertController(title: "Warning", message: "Please pick a category", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            nameCategoryField.text = categories[pickerView2.selectedRow(inComponent: 0)-1]
        }
    }
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(hideKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        nameCategoryField.inputAccessoryView = toolBar
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    @IBAction func editingend(_ sender: Any) {
//        if urlField.text != nil && !urlField.text!.isEmpty && urlField.text != item.url {
//            item.url = urlField.text
//        }
        if nameField.text != nil && !nameField.text!.isEmpty && nameCategoryField.text != nil && !nameCategoryField.text!.isEmpty && costField.text != nil && !costField.text!.isEmpty && durationField.text != nil && !durationField.text!.isEmpty && Int(durationField.text!) != nil && Double(costField.text!) != nil {
//            if (item.name != nameField.text!) || (item.category != nameCategoryField.text!) || (item.price != Double(costField.text!)) || (item.months != Int(durationField.text!)) {
                if Double(costField.text!)! > 0.0  && Int(durationField.text!)! > 0 {
                    nameField.layer.borderWidth = 0
                    nameCategoryField.layer.borderWidth = 0
                    costField.layer.borderWidth = 0
                    durationField.layer.borderWidth = 0
                    nameField.layer.borderColor = .none
                    nameCategoryField.layer.borderColor = .none
                    nameField.layer.borderColor = .none
                    nameField.layer.borderColor = .none
                    doneButton.isEnabled = true
                } else {
                    if Double(costField.text!)! <= 0.0 {
                        costField.layer.borderWidth = 1
                        costField.layer.borderColor = UIColor.systemOrange.cgColor
                    } else {
                        costField.layer.borderWidth = 0
                        costField.backgroundColor = .none
                    }
                    if Int(durationField.text!)! <= 0 {
                        durationField.layer.borderWidth = 1
                        durationField.layer.borderColor = UIColor.systemOrange.cgColor
                    } else {
                        durationField.layer.borderWidth = 0
                        durationField.backgroundColor = .none
                    }
                }
//            }
        } else {
            if nameField.text == nil || nameField.text!.isEmpty {
                nameField.layer.borderWidth = 1
                nameField.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                nameField.layer.borderWidth = 0
                nameField.layer.borderColor = .none
            }
            if nameCategoryField.text == nil || nameCategoryField.text!.isEmpty {
                nameCategoryField.layer.borderWidth = 1
                nameCategoryField.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                nameCategoryField.layer.borderWidth = 0
                nameCategoryField.backgroundColor = .none
            }
            if costField.text == nil || costField.text!.isEmpty {
                costField.layer.borderWidth = 1
                costField.layer.borderColor = UIColor.systemRed.cgColor
            } else if Double(costField.text!) == nil {
                costField.layer.borderWidth = 1
                costField.layer.borderColor = UIColor.systemYellow.cgColor
            } else {
                costField.layer.borderWidth = 0
                costField.backgroundColor = .none
            }
            if durationField.text == nil || durationField.text!.isEmpty {
                durationField.layer.borderWidth = 1
                durationField.layer.borderColor = UIColor.red.cgColor
            } else if Int(durationField.text!) == nil {
                durationField.layer.borderWidth = 1
                durationField.layer.borderColor = UIColor.systemYellow.cgColor
            } else {
                durationField.layer.borderWidth = 0
                durationField.backgroundColor = .none
            }
        }
    }
    @IBAction func editingBegin(_ sender: Any) {
        createToolbar()
        pickerView2.selectRow(0, inComponent: 0, animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func save(_ sender: Any) {
        if nameField.text != nil && nameCategoryField.text != nil && costField.text != nil && durationField.text != nil && !nameField.text!.isEmpty && !nameCategoryField.text!.isEmpty && !costField.text!.isEmpty && !durationField.text!.isEmpty {
            if Double(costField.text!) != nil && Int(durationField.text!) != nil {
                if urlField.text != nil && !(urlField.text!.isEmpty) {
                    wishlist.append(WishlistItem(name: nameField.text!, category: nameCategoryField.text!, price: Double(costField.text!)!, months: Int(durationField.text!)!, url: urlField.text!))
                } else {
                    wishlist.append(WishlistItem(name: nameField.text!, category: nameCategoryField.text!, price: Double(costField.text!)!, months: Int(durationField.text!)!))
                }
//                dismiss(animated: true, completion: nil)
                print(wishlist)
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return (true)
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

}

extension UITableViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
