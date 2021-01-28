//
//  AAaAViewController.swift
//  autolayout'
//
//  Created by Joe Wong on 25/1/21.
//

import UIKit

class AAaAViewController: UIViewController {

    var number: Int = 0
    @IBOutlet weak var labell: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        labell.text = String(number)
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
