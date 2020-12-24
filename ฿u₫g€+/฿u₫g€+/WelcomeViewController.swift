//
//  WelcomeViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 20/12/20.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var monthlyIncomeTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var thingy: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var savingsTargetTextField: UITextField!
    @IBOutlet weak var initialSavingsTextField: UITextField!
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == initialSavingsTextField {
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
//        UserDefaults.standard.setValue("WelcomeViewController", forKey: "LaunchViewController")
        text.adjustsFontSizeToFitWidth = true
        UserDefaults.standard.setValue(false, forKey: "loggedIn")
        doneButton.layer.cornerRadius = 10
        skipButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        thingy.layer.cornerRadius = 15
        thingy.clipsToBounds = true
        
//        UserDefaults.standard.removeObject(forKey: "username")
        if UserDefaults.standard.object(forKey: "username") != nil {
            print("no")
            performSegue(withIdentifier: "navigateHome", sender: nil)
        }
//        stackView.distribution = .fillEqually
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,  selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,  selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//        self.hideKeyboardWhenTappedAround()
//        doneButton.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard(_:)))

        // Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        // tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
//        tap.cancelsTouchesInView = true
        monthlyIncomeTextField.delegate = self
        monthlyIncomeTextField.keyboardType = .numberPad
        savingsTargetTextField.delegate = self
        savingsTargetTextField.keyboardType = .numberPad
        initialSavingsTextField.delegate = self
        initialSavingsTextField.keyboardType = .decimalPad
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            view.frame.origin.y = 0
        }
    }
    @IBAction func hideKeyboard(_ sender: Any) {
        self.resignFirstResponder()
        view.frame.origin.y = 0
        view.endEditing(true)
    }
    
    @IBAction func whenDoneClicked(_ sender: Any) {
        if usernameTextField.text != nil && !usernameTextField.text!.isEmpty && !usernameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty && monthlyIncomeTextField.text != nil && !monthlyIncomeTextField.text!.isEmpty {
            updateGlobalSavings()
            updateProjectedSavings()
            incomeArray[0].incomeMoney = Int(monthlyIncomeTextField.text!)!
            projectedIncome.saveToFile(income: incomeArray)
            updateGlobalSavings()
            updateProjectedSavings()
            if savingsTargetTextField.text != nil && !savingsTargetTextField.text!.isEmpty && !savingsTargetTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//                if Int(savingsTargetTextField.text!)! <= Int(monthlyIncomeTextField.text!)! {
                    savingsArray[1].savingsMoney = Int(savingsTargetTextField.text!)!
//                } else if Int(savingsTargetTextField.text!)! > Int(monthlyIncomeTextField.text!)! {
//                    let alert = UIAlertController(title: "Warning", message: "", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//                        savingsArray[1].savingsMoney = Int(Double(globalincome/5).rounded(.down))
//                    }))
//                    present(alert, animated: true, completion: nil)
//                }
//                UserDefaults.standard.setValue(Int(savingsTargetTextField.text!), forKey: "savingsTarget")
            } else {
                savingsArray[1].savingsMoney = Int(Double(globalincome/5).rounded(.down))
//                UserDefaults.standard.setValue(Double(globalincome/5).rounded(.down), forKey: "savingsTarget")
            }
            projectedSavings.saveToFile(savings: savingsArray)
            updateGlobalSavings()
            updateProjectedSavings()
//            if UserDefaults.standard.object(forKey: "savingsTarget") != nil {
//                for i in expensesArray {
//                    i.projectedExpenses = Int((Double((globalincome-UserDefaults.standard.integer(forKey: "savingsTarget"))/expensesArray.count)).rounded(.down))
//                }
            for i in expensesArray {
                i.projectedExpenses = Int((Double((globalincome-savingsArray[1].savingsMoney)/expensesArray.count)).rounded(.down))
            }
//            } else {
//                for i in expensesArray {
//                    i.projectedExpenses = Int((Double(globalincome-(globalincome/5)/expensesArray.count)).rounded(.down))
//                }
//            }
            expenseStruct.saveToFile(expense: expensesArray)
            updateGlobalSavings()
            updateProjectedSavings()
            UserDefaults.standard.setValue(usernameTextField.text, forKey: "username")
            print(UserDefaults.standard.string(forKey: "username")!)
            performSegue(withIdentifier: "navigateHome", sender: nil)
//            doneButton.isEnabled = true
        } else {
//            if (usernameTextField.text!.isEmpty || usernameTextField.text == nil) && (monthlyIncomeTextField.text!.isEmpty || monthlyIncomeTextField.text == nil) {
                let alert = UIAlertController(title: "Warning", message: "Not all required text fields are filled up", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
//            }
//            if usernameTextField.text!.isEmpty || usernameTextField.text == nil {
//                let alert = UIAlertController(title: "Warning", message: "Name is Empty", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//            } else if usernameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//                let alert = UIAlertController(title: "Warning", message: "Name is Blank", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//            }
//            if monthlyIncomeTextField.text!.isEmpty || monthlyIncomeTextField.text == nil {
//                let alert = UIAlertController(title: "Warning", message: "Income is Empty", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//            } else if monthlyIncomeTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//                let alert = UIAlertController(title: "Warning", message: "Income is Blank", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//            }
        }
    }
    @IBAction func skipButtonTapped(_ sender: Any) {
        updateGlobalSavings()
        updateProjectedSavings()
        incomeArray[0].incomeMoney = 5000
        projectedIncome.saveToFile(income: incomeArray)
        updateGlobalSavings()
        updateProjectedSavings()
        savingsArray[1].savingsMoney = Int(Double(globalincome/5).rounded(.down))
        projectedSavings.saveToFile(savings: savingsArray)
        updateGlobalSavings()
        updateProjectedSavings()
        for i in expensesArray {
            i.projectedExpenses = Int((Double((globalincome-savingsArray[1].savingsMoney)/expensesArray.count)).rounded(.down))
        }
        expenseStruct.saveToFile(expense: expensesArray)
        updateGlobalSavings()
        updateProjectedSavings()
        performSegue(withIdentifier: "navigateHome", sender: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: self.view.window)
        monthlyIncomeTextField.text = ""
        usernameTextField.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
