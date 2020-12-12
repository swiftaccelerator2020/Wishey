//
//  WishlistTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//
import UIKit

class WishlistTableViewController: UITableViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        updateGlobalSavings()
//        tableView.reloadRows(at: [IndexPath(row: <#T##Int#>, section: <#T##Int#>)], with: .none)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
    }
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateGlobalSavings()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(hex: 0x83DB97)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = UIColor(hex: 0x83DB97)
            UINavigationBar.appearance().isTranslucent = false
        }
//        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wishlist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath)

//        cell.myIndexPath = indexPath
        // Configure the cell...
        if let cell = cell as? WishlistTableViewCell {
            cell.wishlistItemTitle.text = wishlist[indexPath.row].name
            cell.wishlistItemCategory.text = wishlist[indexPath.row].category
            print()
            cell.monthlyTarget.text = (Double(wishlist[indexPath.row].price)/Double(wishlist[indexPath.row].months)) != Double(wishlist[indexPath.row].price/wishlist[indexPath.row].months) ? "$\(String(format: "%.2f", Double(wishlist[indexPath.row].price)/Double(wishlist[indexPath.row].months)))/month" : "$\(wishlist[indexPath.row].price/wishlist[indexPath.row].months)/month"
            var savingsDivPriceText = String()
            var currentSavings = savings
            for i in 0..<indexPath.row {
                currentSavings -= Double(wishlist[i].price)
                print(i)
            }
//            cell.currentSavings = currentSavings
            if currentSavings >= Double(wishlist[indexPath.row].price) {
                savingsDivPriceText = "$\(wishlist[indexPath.row].price)/\(wishlist[indexPath.row].price)"
                UIView.animate(withDuration: 4){
                    cell.progressAnimated.progress = CGFloat(1)
                    cell.savingsOutOfPrice.textColor = .systemBackground
                }
            } else {
                if currentSavings > 0 {
                    print(Double(currentSavings)/Double(wishlist[indexPath.row].price))
                    print(Double(currentSavings/Double(wishlist[indexPath.row].price)))
                    savingsDivPriceText = currentSavings.truncatingRemainder(dividingBy: 1) != 0 ? "$\(String(format: "%.2f", currentSavings))/\(wishlist[indexPath.row].price)" : "$\(Int(currentSavings))/\(wishlist[indexPath.row].price)"
                    print(savingsDivPriceText)
//                    if currentSavings.truncatingRemainder(dividingBy: 1) != 0 {
//                        UIView.animate(withDuration: 4){
//                            cell.progressBar.setProgress(Float(Double(currentSavings)/Double(wishlist[indexPath.row].price)), animated: true)
                        cell.progressAnimated.progress = CGFloat(currentSavings/Double(wishlist[indexPath.row].price))
//                        }
//                    } else {
//                        UIView.animate(withDuration: 4){
//                            cell.progressBar.setProgress(Float(Int(currentSavings)/wishlist[indexPath.row].price), animated: true)
//                        cell.progressAnimated.progress = CGFloat(currentSavings/Double(wishlist[indexPath.row].price))
//                        }
//                    }
                    cell.savingsOutOfPrice.textColor = .label
                }
                else {
                    savingsDivPriceText = "$0/\(wishlist[indexPath.row].price)"
//                    cell.progressBar.setProgress(0, animated: false)
                    cell.progressAnimated.progress = CGFloat(0)
                    cell.savingsOutOfPrice.textColor = .label
                }
            }
            print("$\(currentSavings)")
            print(String(format: "%.2f", currentSavings))
            print()
//            if savings > 0 {
//                if savings >= wishlist[indexPath.row].price {
//                    savingsDivPriceText = "$\(wishlist[indexPath.row].price)/\(wishlist[indexPath.row].price)"
//                } else /*if savings < wishlist[indexPath.row].price*/ {
//                    savingsDivPriceText = "$\(savings)/\(wishlist[indexPath.row].price)"
//                }
//            savings -= wishlist[indexPath.row].price
//            print(savings)
////            } else {
//            }
////                savings = 0
//                savingsDivPriceText = "$\(savings)/\(wishlist[indexPath.row].price)"
//            }
//            if savings == 0 {
//                savingsDivPriceText = "0/\(wishlist[indexPath.row].price)"
//            } else {
//            //else if savings < wishlist[indexPath.row].price {
//
//            //}
//            }
            cell.savingsOutOfPrice.text = savingsDivPriceText
        }
        
        cell.selectionStyle = .none
        
        return cell
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
    
    @IBAction func unwindToWishlist( _ seg: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsSegue", sender: nil)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            wishlist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            wishlist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        let spend = UIContextualAction(style: .normal, title: "Spend") {  (contextualAction, view, boolValue) in
            wishlistSpendings += Double(wishlist[indexPath.row].price)
            wishlist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            print(savings)
            updateGlobalSavings()
            tableView.reloadData()
        }
        spend.backgroundColor = UIColor.systemBlue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, spend])

        return swipeActions
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let friend = wishlist.remove(at: fromIndexPath.row)
        wishlist.insert(friend, at: to.row)
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailsSegue" {
//            let destViewController = segue.destination as! UINavigationController
//            let secondViewcontroller = destViewController.viewControllers.first as! DetailsTableViewController
            let destVC = segue.destination as! DetailsTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            destVC.item = wishlist[indexPath!.row]
            destVC.theIndexPath = indexPath
        }
    }

}
