//
//  SendMoneyFormViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

class SendMoneyFormViewController: BaseViewController, SendMoneyFormViewModelDelegate, UITableViewDelegate, UITableViewDataSource, FormOptionsViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var submitButton: BaseButton!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = SendMoneyFormViewModel()
    var data: [Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableView()
        setupUI()
        navBarTitle = LocalizedString.sendMoneyApp.localized
        loadData()
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillShow(_:)),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil
                )
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillHide(_:)),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil
                )
    }
    
    func setupUI() {
        submitButton.buttonStyle = .primaryButton
        submitButton.setTitle(LocalizedString.send.localized, for: .normal)
    }
    
    func loadData() {
        viewModel.delegate = self
        viewModel.fetchFormData()
    }

    func registerTableView() {
        tableView.register(UINib(nibName: "FormOptionsTableViewCell", bundle: nil), forCellReuseIdentifier: FormOptionsTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "FormTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: FormTextFieldTableViewCell.reuseIdentifier)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
           guard let userInfo = notification.userInfo,
                 let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
           
           let keyboardHeight = keyboardFrame.height
           let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
           
           tableView.contentInset = contentInset
           tableView.scrollIndicatorInsets = contentInset
       }
    @objc func keyboardWillHide(_ notification: Notification) {
            let contentInset = UIEdgeInsets.zero
            tableView.contentInset = contentInset
            tableView.scrollIndicatorInsets = contentInset
        }
    // MARK: - SendMoneyFormViewModelDelegate
    func loadSendMoneyFormData(data: [Any]?) {
        navBarTitle = viewModel.sendMoneyData?.title?.en ?? LocalizedString.sendMoneyApp.localized
        self.data = data
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data?[indexPath.row]
        if let cellModel = cellData as? FormOptionsTableViewCellModel{
            let cell = tableView.dequeueReusableCell(withIdentifier: FormOptionsTableViewCell.reuseIdentifier, for: indexPath) as! FormOptionsTableViewCell
            cell.data = cellModel
            cell.formOptionsView.delegate = self
            return cell
        }
        if let cellModel = cellData as? FormTextFieldTableViewCellModel{
            let cell = tableView.dequeueReusableCell(withIdentifier: FormTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! FormTextFieldTableViewCell
            cell.data = cellModel
            cell.formTextFieldView.textField.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - FormOptionsViewDelegate
    func didSelectShowOptions() {
        print("show options")
    }
    
    @IBAction func sendAction(_ sender: Any) {
        print("save action")
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
