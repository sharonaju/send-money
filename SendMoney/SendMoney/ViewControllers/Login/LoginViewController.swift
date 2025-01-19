//
//  LoginViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 17/01/2025.
//

import UIKit

class LoginViewController: BaseViewController, FormTextFieldViewDelegate {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var sendMoneyLabel: BaseLabel!
    @IBOutlet weak var welcomeLabel: BaseLabel!
    @IBOutlet weak var emailFieldView: FormTextFieldView!
    @IBOutlet weak var passwordFieldView: FormTextFieldView!
    @IBOutlet weak var byProceedingLabel: BaseLabel!
    @IBOutlet weak var loginButton: BaseButton!
    
    var viewModel = LoginViewModel()
    
    // MARK: - UIViewControllerLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitle = LocalizedString.signin.localized
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        connectDelegates()
    }
    override func refreshUI() {
        super.refreshUI()
        setupUI()
    }
    // MARK: - CustomMethods
    func setupUI(){
        sendMoneyLabel.style = .primaryMedium16
        welcomeLabel.style = .secondaryMedium14
        byProceedingLabel.style = .secondaryMedium12
        loginButton.buttonStyle = .primaryButton
        sendMoneyLabel.text = LocalizedString.sendMoneyApp.localized
        welcomeLabel.text = LocalizedString.welcomeToSendMoneyApp.localized
        byProceedingLabel.text = LocalizedString.byProceedingYouAgreeToTerms.localized
        let emailFormMode = FormTextFieldViewModel(title: nil, textfieldPlaceHolder: LocalizedString.email.localized, textFieldKeybordType: .emailAddress)
        emailFieldView.data = emailFormMode
        let passwordFormMode = FormTextFieldViewModel(title: nil, textfieldPlaceHolder: LocalizedString.password.localized, textFieldKeybordType: .default)
        passwordFieldView.data = passwordFormMode
        loginButton.setTitle(LocalizedString.signin.localized, for: .normal)
        emailFieldView.textField.text = Constants.validEmail
        passwordFieldView.textField.text = Constants.validPassword
    }
    func connectDelegates(){
        emailFieldView.delegate = self
        passwordFieldView.delegate = self
    }
    
    // MARK: - @IBActions
    @IBAction func signinButtonAction(_ sender: Any) {
        if let emailValiadtionMessage = viewModel.validateEmail(email: emailFieldView.textField.text){
            emailFieldView.errorMessage = emailValiadtionMessage
            return
        }
        if let passwordValidationMessage = viewModel.validatePassword(password: passwordFieldView.textField.text){
            passwordFieldView.errorMessage = passwordValidationMessage
            return
        }
        navigateToSendMoneyView()
    }
    
    // MARK: - Navigations
    func navigateToSendMoneyView(){
        if let nextVC = storyboard?.instantiateViewController(withIdentifier: "SendMoneyFormViewController") as? SendMoneyFormViewController {
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    // MARK: - FormTextFieldViewDelegate
    func formTextFieldShouldReturn(type: FormTextFieldView.ViewType?) {
        if type == .email{
            passwordFieldView.textField.becomeFirstResponder()
        } else {
            passwordFieldView.textField.resignFirstResponder()
        }
    }
    func formTextFieldDidBeginEditing(type: FormTextFieldView.ViewType?) {
        emailFieldView.hideError()
        passwordFieldView.hideError()
    }
    func formTextFieldDidEndEditing(text: String?, requiredFieldValue: RequiredFieldValue?, type: FormTextFieldView.ViewType?) {
        
    }

}

