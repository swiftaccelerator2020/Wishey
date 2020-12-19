//
//  MainTabBarViewController.swift
//  ฿u₫g€+
//
//  Created by Granwyn Tan on 30/11/20.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateProjectedSavings()
        updateGlobalSavings()
        self.selectedIndex = 1
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateProjectedSavings()
        print(UserDefaults.standard.string(forKey: "lastRecordedMonth") ?? "none")
        updateGlobalSavings()
        updateForCurrentMonth()
        self.selectedIndex = 1
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
            UINavigationBar.appearance().barTintColor = /*UIColor(hex: 0x83DB97)*/ UIColor.systemGreen
            UINavigationBar.appearance().isTranslucent = false
        }
//        print(Date().startOfDay.dayAsString())
//        if Date().startOfDay.dayAsString() == "18" {
//            if let loadedIncome = projectedIncome.loadFromFile() {
//                for i in 0...loadedIncome.count-1 {
//                    loadedIncome[i].incomeMoney = 0
//                }
//                projectedIncome.saveToFile(income: loadedIncome)
//            }
//            wishlist = []
//            for i in expensesArray {
//                i.actualExpenses = 0
//            }
//            WishlistItem.saveToFile(wishlist: wishlist)
//            expenseStruct.saveToFile(expense: expensesArray)
//        }
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
