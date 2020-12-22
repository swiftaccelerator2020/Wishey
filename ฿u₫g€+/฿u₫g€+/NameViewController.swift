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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,  selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,  selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: self.view.window)
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
