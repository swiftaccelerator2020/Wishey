//
//  StartViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 21/12/20.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(UserDefaults.standard.bool(forKey: "loggedIn"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateTotalSavings()
        updateWishlistTransactions()
        updateInitialSavings()
        updateCurrency()
//        if UserDefaults.standard.object(forKey: "loggedIn") != nil {
//            if UserDefaults.standard.bool(forKey: "loggedIn") == false {
//                self.present(WelcomeViewController(), animated: true, completion: nil)
//            } else {
//                self.present(MainTabBarViewController(), animated: true, completion: nil)
//            }
//        } else {
//            print("lol")
//            self.present(WelcomeViewController(), animated: true, completion: nil)
//        }
        
        if UserDefaults.standard.object(forKey: "loggedIn") != nil {
            if UserDefaults.standard.bool(forKey: "loggedIn") == false {
//                self.present(WelcomeViewController(), animated: true, completion: nil)
//
                performSegue(withIdentifier: "welcomeScreen", sender: nil)
            } else {
//                self.present(MainTabBarViewController(), animated: true, completion: nil)
                performSegue(withIdentifier: "showTabBar", sender: nil)
            }
        } else {
//            print("lol")
//            self.present(WelcomeViewController(), animated: true, completion: nil)
            performSegue(withIdentifier: "welcomeScreen", sender: nil)
        }
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
