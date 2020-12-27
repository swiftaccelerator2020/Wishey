//
//  WishlistTopTableViewCell.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 22/12/20.
//

import UIKit

class WishlistTopTableViewCell: UITableViewCell, UITextFieldDelegate {
    
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
    
    weak var tableViewController: WishlistTableViewController?
    
    weak var delegate: CustomCellUpdater?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var value: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
//    var theIndexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        value.keyboardType = .decimalPad
        value.delegate = self
    }

    @IBAction func hideKeyboard(_ sender: Any) {
        tableViewController?.resignFirstResponder()
    }
    @IBAction func editInitialSavings(_ sender: Any) {
        if value.text == nil || value.text!.isEmpty || value.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            value.text = "0.00"
        }
        UserDefaults.standard.setValue(value.text, forKey: "initialSavings")
        print(UserDefaults.standard.string(forKey: "initialSavings")!)
        updateInitialSavings()
        canBuy = []
        updateProjectedSavings()
        updateGlobalSavings()
        tableViewController?.updateTableView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
