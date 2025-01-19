//
//  FormTextFieldView.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

struct FormTextFieldViewModel{
    var title: String?
    var textfieldPlaceHolder: String?
    var textFieldKeybordType: UIKeyboardType?
    var textFieldValue: String?
    var requiredField: RequiredFieldValue?
    var type: FormTextFieldView.ViewType?
    var errorMessage: String?
}

protocol FormTextFieldViewDelegate {
    func formTextFieldDidBeginEditing(type: FormTextFieldView.ViewType?)
    func formTextFieldShouldReturn(type: FormTextFieldView.ViewType?)
    func formTextFieldDidEndEditing(text: String?, requiredFieldValue: RequiredFieldValue?, type: FormTextFieldView.ViewType?)
}

class FormTextFieldView: UIView, UITextFieldDelegate {
    
    enum ViewType{
        case email
        case password
        case form
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorLabel: BaseLabel!
    @IBOutlet weak var textField: BaseTextField!
    @IBOutlet weak var titleLabel: BaseLabel!
    
    var data: FormTextFieldViewModel? {
        didSet {
            loadData()
        }
    }
    var errorMessage: String? {
        didSet {
            showError()
        }
    }
    var delegate: FormTextFieldViewDelegate?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("FormTextFieldView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("FormTextFieldView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    func setupUI() {
        titleLabel.style = .primaryMedium16
        errorLabel.style = .errorMedium12
        textField.layer.cornerRadius = 5
        textField.backgroundColor = CustomColors.formFieldBackgroundColor
        textField.leftSidePadding = 14
        hideError()
    }
    func showError(){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CustomColors.errorColor.cgColor
        errorLabel.text = errorMessage ?? data?.errorMessage
    }
    func hideError() {
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.clear.cgColor
        errorLabel.text = ""
    }
    func loadData() {
        if let title = data?.title{
            titleLabel.isHidden = false
            titleLabel.text = title
        } else{
            titleLabel.isHidden = true
        }
        if let reqFormDataType = data?.requiredField?.requiredField?.type{
            switch reqFormDataType {
            case .msisdn:
                textField.keyboardType = .phonePad
            case .number:
                textField.keyboardType = .numbersAndPunctuation
            case .text:
                textField.keyboardType = .default
            default:
                break
            }
        } else{
            textField.keyboardType = data?.textFieldKeybordType ?? .default
        }
        textField.placeholder = data?.textfieldPlaceHolder
        
        if let textFieldValue = data?.textFieldValue{
            textField.text = textFieldValue
        } else{
            textField.text = nil
        }
        if (data?.errorMessage) != nil {
            showError()
        } else{
            hideError()
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.formTextFieldDidBeginEditing(type: data?.type)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let type = data?.type {
            switch type {
            case .email, .password:
                delegate?.formTextFieldDidEndEditing(text: textField.text, requiredFieldValue: nil, type: type)
            case .form:
                let reqFieldValue = RequiredFieldValue(requiredField: data?.requiredField?.requiredField, valueString: textField.text, valueOption: nil)
                delegate?.formTextFieldDidEndEditing(text: textField.text, requiredFieldValue: reqFieldValue, type: type)
            }
        }
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.formTextFieldShouldReturn(type: data?.type)
        return true
    }

}
