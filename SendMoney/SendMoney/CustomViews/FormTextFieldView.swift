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
}

class FormTextFieldView: UIView {
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
        errorLabel.text = errorMessage
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
        textField.placeholder = data?.textfieldPlaceHolder
        textField.keyboardType = data?.textFieldKeybordType ?? .default
    }

}
