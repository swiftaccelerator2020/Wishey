//
//  DetailsTableViewController.swift
//  ฿u₫g€+
//
//  Created by Adam Tan on 11/12/20.
//

import UIKit
import SafariServices

class DetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemCatTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    @IBOutlet weak var URLTF: UITextField!
    var item: WishlistItem!
    var theIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        itemNameTF.text = item.name
        itemCatTF.text  = item.category
        priceTF.text = String(item.price)
        durationTF.text = String(item.months)
        URLTF.text = item.url
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        if URLTF.text != nil && !URLTF.text!.isEmpty {
            item.url = URLTF.text
        }
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
