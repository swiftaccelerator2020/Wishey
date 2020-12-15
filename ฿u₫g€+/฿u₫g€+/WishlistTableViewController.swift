//
//  WishlistTableViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//
import UIKit

class WishlistTableViewController: UITableViewController {
    
    var canBuy: [Bool] = []
    
    override func viewDidAppear(_ animated: Bool) {
        updateGlobalSavings()
//        tableView.reloadRows(at: [IndexPath(row: <#T##Int#>, section: <#T##Int#>)], with: .none)
        canBuy = []
        tableView.reloadData()
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tableView.setEditing(editing, animated: true)
    }
    var indexPath = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
//        tableView.allowsMultipleSelection = true
////        tableView.allowsSelectionDuringEditing = true
//        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.dataSource = self
        tableView.delegate = self
    }
//    @IBAction func editButtonTapped(_ sender: Any) {
//        if tableView.isEditing {
//            tableView.setEditing(false, animated: true)
//        } else {
//            tableView.setEditing(true, animated: true)
//        }
//    }
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let spend = UIContextualAction(style: .normal, title: "Spend") {  (contextualAction, view, boolValue) in
//            wishlistSpendings += Double(wishlist[indexPath.row].price)
//            wishlist.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .none)
//            print(savings)
//            self.canBuy = []
//            updateGlobalSavings()
//            tableView.reloadData()
//        }
////        spend.backgroundColor = UIColor.systemGreen
//        let swipeActions = UISwipeActionsConfiguration(actions: [spend])
//        return swipeActions
//    }
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateGlobalSavings()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = /*UIColor(hex: 0x83DB97)*/ UIColor.systemGreen
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = /*UIColor.systemGreen*/ UIColor.systemGreen
            UINavigationBar.appearance().isTranslucent = false
        }
        canBuy = []
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
            cell.progressAnimated.layer.cornerRadius = 0
//            cell.accessoryView?.backgroundColor = .systemGreen
//            cell.editingAccessoryView?.backgroundColor = .systemGreen
//            cell.backgroundColor = .systemGreen
//            cell.contentView.backgroundColor = .systemRed
//            cell.backgroundView?.backgroundColor = .systemGray
            cell.wishlistItemTitle.text = wishlist[indexPath.row].name
            cell.wishlistItemCategory.text = wishlist[indexPath.row].category
//            cell.showsReorderControl = false
//            cell.showingDeleteConfirmation = false
            print()
            cell.monthlyTarget.text = /*(Double(wishlist[indexPath.row].price)/Double(wishlist[indexPath.row].months)) != Double(wishlist[indexPath.row].price/Double(wishlist[indexPath.row].months)) ? */ "$\(String(format: "%.2f", (wishlist[indexPath.row].price/Double(wishlist[indexPath.row].months))))/month" /* : "$\(wishlist[indexPath.row].price/Double(wishlist[indexPath.row].months))/month"*/
            
            var savingsDivPriceText = String()
            var currentSavings = savings
            for i in 0..<indexPath.row {
                currentSavings -= Double(wishlist[i].price)
                print(i)
            }
//            cell.contentView.trailingAnchor
//            cell.currentSavings = currentSavings
            if currentSavings >= Double(wishlist[indexPath.row].price) {
                savingsDivPriceText = "$\(String(format: "%.2f", wishlist[indexPath.row].price))/\(String(format: "%.2f", wishlist[indexPath.row].price))"
                UIView.animate(withDuration: 4){
                    cell.progressAnimated.progress = CGFloat(1)
//                    cell.savingsOutOfPrice.textColor = .systemBackground
                }
//                cell.backgroundColor = /*UIColor(hex: 0x83DB97)*/ UIColor.systemGreen
                cell.accessoryView?.backgroundColor = /*UIColor(hex: 0x83DB97)*/ UIColor.systemGreen
                canBuy.append(true)
            } else {
                if currentSavings > 0 {
                    print(Double(currentSavings)/Double(wishlist[indexPath.row].price))
                    print(Double(currentSavings/Double(wishlist[indexPath.row].price)))
                    savingsDivPriceText = /*currentSavings.truncatingRemainder(dividingBy: 1) != 0 ? "$\(String(format: "%.2f", currentSavings))/\(wishlist[indexPath.row].price)" : "$\(Int(currentSavings))/\(wishlist[indexPath.row].price)"*/ "$\(String(format: "%.2f", currentSavings))/\(String(format: "%.2f", wishlist[indexPath.row].price))"
//                    cell.backgroundColor = /*UIColor(hex: 0x83DB97)*/ UIColor.systemGreen
//                    cell.accessoryView?.backgroundColor = .systemBackground
                    print(savingsDivPriceText)
//                    if currentSavings.truncatingRemainder(dividingBy: 1) != 0 {
//                        UIView.animate(withDuration: 4){
//                            cell.progressBar.setProgress(Float(Double(currentSavings)/Double(wishlist[indexPath.row].price)), animated: true)
                        cell.progressAnimated.progress = CGFloat(currentSavings/wishlist[indexPath.row].price)
//                        }
//                    } else {
//                        UIView.animate(withDuration: 4){
//                            cell.progressBar.setProgress(Float(Int(currentSavings)/wishlist[indexPath.row].price), animated: true)
//                        cell.progressAnimated.progress = CGFloat(currentSavings/Double(wishlist[indexPath.row].price))
//                        }
//                    }
//                    cell.savingsOutOfPrice.textColor = .label
                    canBuy.append(false)
                }
                else {
                    savingsDivPriceText = "$0.00/\(String(format: "%.2f", wishlist[indexPath.row].price))"
//                    cell.progressBar.setProgress(0, animated: false)
                    cell.progressAnimated.progress = CGFloat(0)
//                    cell.savingsOutOfPrice.textColor = .label
                    cell.backgroundColor = .systemBackground
                    canBuy.append(false)
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
        
//        let subviews = cell.backgroundView?.subviews
//        for i in 0..<subviews!.count {
//            subviews![i].removeFromSuperview()
//        }
        
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
        canBuy = []
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsSegue", sender: nil)
//        let cell: UITableViewCell = tableView.cellForRow(at: indexPath)!
//        cell.accessoryType = cell.isSelected ? .checkmark : .none
    }
//    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
//     }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? WishlistTableViewCell
        cell?.editingAccessoryView?.backgroundColor = .systemGreen
        cell?.progressAnimated.layer.cornerRadius = 10
        if editingStyle == .delete {
            // Delete the row from the data source
            wishlist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            canBuy = []
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            wishlist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.canBuy = []
            tableView.reloadData()
        }
        let edit = UIContextualAction(style: .destructive, title: "Edit") {  (contextualAction, view, boolValue) in
            self.indexPath = indexPath
            self.performSegue(withIdentifier: "detailsSegue", sender: nil)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            self.canBuy = []
//            tableView.reloadData()
        }
        edit.backgroundColor = .systemBlue
        var swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        if canBuy[indexPath.row] == true{
            let spend = UIContextualAction(style: .normal, title: "Spend") {  (contextualAction, view, boolValue) in
                wishlistSpendings += Double(wishlist[indexPath.row].price)
                wishlist.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .none)
                print(savings)
                self.canBuy = []
                updateGlobalSavings()
                tableView.reloadData()
            }
            spend.backgroundColor = UIColor.systemYellow
            swipeActions = UISwipeActionsConfiguration(actions: [delete, edit, spend])
        }

        return swipeActions
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let friend = wishlist.remove(at: fromIndexPath.row)
        wishlist.insert(friend, at: to.row)
        self.canBuy = []
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
            if tableView.indexPathForSelectedRow != nil {
                indexPath = tableView.indexPathForSelectedRow!
            }
            destVC.item = wishlist[indexPath.row]
            destVC.theIndexPath = indexPath
        }
    }

}
