//
//  LoginViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 17/01/2025.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var sendMoneyLabel: BaseLabel!
    @IBOutlet weak var welcomeLabel: BaseLabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitle = LocalizedString.signin.localized
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    func setupUI(){
        sendMoneyLabel.style = .primaryMedium16
        welcomeLabel.style = .secondaryMedium14
        sendMoneyLabel.text = LocalizedString.sendMoneyApp.localized
        welcomeLabel.text = LocalizedString.welcomeToSendMoneyApp.localized
    }

}

