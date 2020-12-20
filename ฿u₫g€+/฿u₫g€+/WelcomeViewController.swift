//
//  WelcomeViewController.swift
//  ฿u₫g€+
//
//  Created by Edwin Ti on 20/12/20.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        
        UserDefaults.standard.removeObject(forKey:"username")
        print(UserDefaults.standard.object(forKey: "username"))
        if UserDefaults.standard.object(forKey: "username") != nil {
            print("no")
            performSegue(withIdentifier: "navigateHome", sender: nil)
        }
    }
    
    @IBAction func whenDoneClicked(_ sender: Any) {
        UserDefaults.standard.setValue(usernameTextField.text, forKey: "username")
        print(UserDefaults.standard.string(forKey: "username")!)
        performSegue(withIdentifier: "navigateHome", sender: nil)
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
