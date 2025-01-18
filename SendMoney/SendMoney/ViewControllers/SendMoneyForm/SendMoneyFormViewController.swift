//
//  SendMoneyFormViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

class SendMoneyFormViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        navBarTitle = LocalizedString.sendMoneyApp.localized
        
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
