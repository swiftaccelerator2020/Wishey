//
//  WishlistTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//

import UIKit

class WishlistTableViewController: UITableViewController {
    
    struct WishlistItem {
        var name: String
        var category: String
        var price: Int
        var months: Int
    }

    var savings = 1000
    var currentSavings = Int()
    var wishlist: [WishlistItem] = [
        WishlistItem(name: "Watch", category: "Luxury", price: 300, months: 3),
        WishlistItem(name: "Gaming Chair", category: "Entertainment", price: 440, months: 11),
        WishlistItem(name: "Running Shoes", category: "Sports", price: 100, months: 20),
        WishlistItem(name: "New Television", category: "Electronics", price: 1500, months: 3)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        currentSavings = savings
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return wishlist.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath)

        // Configure the cell...
        if let cell = cell as? WishlistTableViewCell {
            cell.wishlistItemTitle.text = wishlist[indexPath.section].name
            cell.wishlistItemCategory.text = wishlist[indexPath.section].category
            cell.monthlyTarget.text = "$\(wishlist[indexPath.section].price/wishlist[indexPath.section].months)/month"
            currentSavings -= wishlist[indexPath.section].price
            print(currentSavings)
            var savingsDivPriceText = String()
            savingsDivPriceText = "\(savings-currentSavings)/\(wishlist[indexPath.section].price)"
//            if savings == 0 {
//                savingsDivPriceText = "0/\(wishlist[indexPath.section].price)"
//            } else {
//            //else if savings < wishlist[indexPath.section].price {
//
//            //}
//            }
            cell.savingsOutOfPrice.text = savingsDivPriceText
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
