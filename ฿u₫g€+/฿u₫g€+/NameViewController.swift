//
//  NameViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 22/12/20.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        delete.layer.cornerRadius = 10
        cancel.layer.cornerRadius = 10
        save.layer.cornerRadius = 10
        delete.setTitleColor(UIColor.systemRed.withAlphaComponent(0.25), for: .disabled)
        if let name = UserDefaults.standard.string(forKey: "username") {
            nameTF.text = name
            delete.isEnabled = true
            title = "Edit Name"
        } else {
            delete.isEnabled = false
            title = "Set Name"
        }
    }
    @IBAction func hideKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    //    @IBAction func endEditing(_ sender: Any) {
//        if nameTF.text != nil && !nameTF.text!.isEmpty && !nameTF.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//            UserDefaults.standard.setValue(nameTF.text, forKey: "username")
//            print(UserDefaults.standard.string(forKey: "username")!)
//            performSegue(withIdentifier: "nameHome", sender: nil)
//            save.isEnabled = true
//        } else {
//            if nameTF.text!.isEmpty || nameTF.text == nil {
//                let alert = UIAlertController(title: "Warning", message: "Name is Empty", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//            } else if nameTF.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//                let alert = UIAlertController(title: "Warning", message: "Name is Blank", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//            }
//        }
//    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        if nameTF.text != nil && !nameTF.text!.isEmpty && !nameTF.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            UserDefaults.standard.setValue(nameTF.text, forKey: "username")
            print(UserDefaults.standard.string(forKey: "username")!)
            performSegue(withIdentifier: "nameHome", sender: nil)
        } else {
            if nameTF.text!.isEmpty || nameTF.text == nil {
                let alert = UIAlertController(title: "Warning", message: "Name is Empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else if nameTF.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                let alert = UIAlertController(title: "Warning", message: "Name is Blank", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func deleteAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username")
        performSegue(withIdentifier: "nameHome", sender: nil)
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
