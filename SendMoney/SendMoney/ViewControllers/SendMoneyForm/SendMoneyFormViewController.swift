//
//  SendMoneyFormViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

class SendMoneyFormViewController: BaseViewController, SendMoneyFormViewModelDelegate, UITableViewDelegate, UITableViewDataSource, FormOptionsViewDelegate, UITextFieldDelegate, CustomPickerDelegate, FormTextFieldViewDelegate {
    
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

    override func refreshUI() {
        super.refreshUI()
        self.view.layoutSubviews()
        viewModel.createViewData(shouldValidateForm: false)
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
    func loadSendMoneyFormData(data: [Any]?, isValidData: Bool?) {
        navBarTitle = viewModel.sendMoneyData?.title?.en ?? LocalizedString.sendMoneyApp.localized
        self.data = data
        tableView.reloadData()
        if isValidData == true {
            
        }
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
            cell.formTextFieldView.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - FormOptionsViewDelegate
    func didSelectShowOptions(type: FormOptionsType?, requiredField: RequiredFieldValue?) {
        if let selectedType = type {
            switch selectedType {
            case .service:
                if let serviceOptions = viewModel.serviceOptions() {
                    showPicker(data: serviceOptions, type: .services)
                }
            case .provider:
                if let providers = viewModel.providerOptions(){
                    showPicker(data: providers, type: .providers)
                }
            case .requiredField:
                if let requiredField = requiredField?.requiredField {
                    showPicker(data: [requiredField], type: .options)
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func sendAction(_ sender: Any) {
        viewModel.createViewData(shouldValidateForm: true)
    }
    
    // MARK: - Picker Display
    private func showPicker(data: [Any], type: PickerCategory) {
        let picker = CustomPickerView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-200, width: view.frame.size.width, height: 400))
        view.addSubview(picker)

        picker.configure(with: data, type: type, delegate: self)
        picker.alpha = 0
        UIView.animate(withDuration: 0.3) {
            picker.alpha = 1
        }
    }
    // MARK: - CustomPickerDelegate
        func didSelectItem(_ selectedItem: Any) {
            switch selectedItem {
            case let service as Service:
                viewModel.formInputValue.selectedService = service
                viewModel.formInputValue.selectedProvider = nil
            case let provider as Provider:
                viewModel.formInputValue.selectedProvider = provider
                viewModel.formInputValue.requiredFields = nil
                if let reqFields = provider.requiredFields {
                    viewModel.formInputValue.requiredFields = [RequiredFieldValue]()
                    for item in reqFields {
                        let reqFieldValue = RequiredFieldValue(requiredField: item, valueString: nil, valueOption: nil)
                        viewModel.formInputValue.requiredFields?.append(reqFieldValue)
                    }
                }
            case let inputValue as RequiredFieldValue:
                viewModel.updateRequiredFieldValue(reqFieldValue: inputValue)
            default:
                break
            }
            viewModel.createViewData(shouldValidateForm: false)
        }
    // MARK: - FormTextFieldViewDelegate
    func formTextFieldShouldReturn(type: FormTextFieldView.ViewType?) {
        
    }
    func formTextFieldDidBeginEditing(type: FormTextFieldView.ViewType?) {
    }
    func formTextFieldDidEndEditing(text: String?, requiredFieldValue: RequiredFieldValue?, type: FormTextFieldView.ViewType?) {
        if let inputValue = requiredFieldValue {
            viewModel.updateRequiredFieldValue(reqFieldValue: inputValue)
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
