//
//  DetailsTableViewController.swift
//  ฿u₫g€+
//
//  Created by Adam Tan on 11/12/20.
//

import UIKit
import SafariServices

class DetailsTableViewController: UITableViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemCatTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    @IBOutlet weak var URLTF: UITextField!
    @IBOutlet var cells: [UITableViewCell]!
    @IBOutlet weak var saveChangesButton: UIBarButtonItem!
    var item: WishlistItem!
    var theIndexPath: IndexPath!
    var pickerView1 = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView1.delegate = self
        pickerView1.dataSource = self
        itemNameTF.text = item.name
        itemCatTF.text  = item.category
        priceTF.text = String(item.price)
        durationTF.text = String(item.months)
        URLTF.text = item.url
        saveChangesButton.isEnabled = false
        itemCatTF.inputView = pickerView1
        itemNameTF.layer.cornerRadius = 5
        itemNameTF.clipsToBounds = true
        itemCatTF.layer.cornerRadius = 5
        itemCatTF.clipsToBounds = true
        priceTF.layer.cornerRadius = 5
        priceTF.clipsToBounds = true
        durationTF.layer.cornerRadius = 5
        durationTF.clipsToBounds = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        for i in cells {
            i.selectionStyle = .none
        }
        self.hideKeyboardWhenTappedAround()
    }
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DetailsTableViewController.hideKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        itemCatTF.inputAccessoryView = toolBar
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemCatTF.resignFirstResponder()
        itemCatTF.text = categories[pickerView.selectedRow(inComponent: 0)]
    }
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
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
    
    @IBAction func editingend(_ sender: Any) {
        if URLTF.text != nil && !URLTF.text!.isEmpty && URLTF.text != item.url {
            item.url = URLTF.text
        }
        if itemNameTF.text != nil && !itemNameTF.text!.isEmpty && itemCatTF.text != nil && !itemCatTF.text!.isEmpty && priceTF.text != nil && !priceTF.text!.isEmpty && durationTF.text != nil && !durationTF.text!.isEmpty && Int(durationTF.text!) != nil && Int(priceTF.text!) != nil {
            if (item.name != itemNameTF.text!) || (item.category != itemCatTF.text!) || (item.price != Int(priceTF.text!)) || (item.months != Int(durationTF.text!)) {
                itemNameTF.layer.borderWidth = 0
                itemCatTF.layer.borderWidth = 0
                priceTF.layer.borderWidth = 0
                durationTF.layer.borderWidth = 0
                itemNameTF.layer.borderColor = .none
                itemCatTF.layer.borderColor = .none
                itemNameTF.layer.borderColor = .none
                itemNameTF.layer.borderColor = .none
                saveChangesButton.isEnabled = true
            }
        } else {
            if itemNameTF.text == nil || itemNameTF.text!.isEmpty {
                itemNameTF.layer.borderWidth = 1
                itemNameTF.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                itemNameTF.layer.borderWidth = 0
                itemNameTF.layer.borderColor = .none
            }
            if itemCatTF.text == nil || itemCatTF.text!.isEmpty {
                itemCatTF.layer.borderWidth = 1
                itemCatTF.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                itemCatTF.layer.borderWidth = 0
                itemCatTF.backgroundColor = .none
            }
            if priceTF.text == nil || priceTF.text!.isEmpty {
                priceTF.layer.borderWidth = 1
                priceTF.layer.borderColor = UIColor.systemRed.cgColor
            } else if Int(priceTF.text!) == nil {
                priceTF.layer.borderWidth = 1
                priceTF.layer.borderColor = UIColor.systemYellow.cgColor
            } else {
                priceTF.layer.borderWidth = 0
                priceTF.backgroundColor = .none
            }
            if durationTF.text == nil || durationTF.text!.isEmpty {
                durationTF.layer.borderWidth = 1
                durationTF.layer.borderColor = UIColor.red.cgColor
            } else if Int(durationTF.text!) == nil {
                durationTF.layer.borderWidth = 1
                durationTF.layer.borderColor = UIColor.systemYellow.cgColor
            } else {
                durationTF.layer.borderWidth = 0
                durationTF.backgroundColor = .none
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if itemNameTF.text != nil && itemCatTF.text != nil && priceTF.text != nil && durationTF.text != nil && !itemNameTF.text!.isEmpty && !itemCatTF.text!.isEmpty && !priceTF.text!.isEmpty && !durationTF.text!.isEmpty {
            if Double(priceTF.text!) != nil && Int(durationTF.text!) != nil {
                if URLTF.text != nil && !(URLTF.text!.isEmpty) {
                    wishlist[theIndexPath.row]  = WishlistItem(name: itemNameTF.text!, category: itemCatTF.text!, price: Int(priceTF.text!)!, months: Int(durationTF.text!)!, url: URLTF.text!)
                } else {
                    wishlist[theIndexPath.row]  = WishlistItem(name: itemNameTF.text!, category: itemCatTF.text!, price: Int(priceTF.text!)!, months: Int(durationTF.text!)!)
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
    
    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsSegue", for: indexPath)
//    }
    
    @IBAction func openLink(_ sender: Any) {
        if item.url != nil && !item.url!.isEmpty {
            if URL(string: item.url!) != nil {
                UIApplication.shared.open(URL(string: item.url!)!, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "URL does not start with \"https://\"", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "No URL available to open", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
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
