//
//  FormOptionsView.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

protocol FormOptionsViewDelegate {
    func didSelectShowOptions(type: FormOptionsType?, requiredField: RequiredFieldValue?)
}
struct FormOptionsViewModel {
    var title: String?
    var selectedTitle: String?
    var type: FormOptionsType?
    var requiredField: RequiredFieldValue?
    var errorMessage: String?
}
enum FormOptionsType {
    case service
    case provider
    case requiredField
}

class FormOptionsView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var formFieldView: UIView!
    @IBOutlet weak var selectedTitleLabel: BaseLabel!
    @IBOutlet weak var errorLabel: BaseLabel!
    
    var delegate: FormOptionsViewDelegate?
    var data: FormOptionsViewModel? {
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
        Bundle.main.loadNibNamed("FormOptionsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("FormOptionsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        hideError()
        
    }
    func setupUI() {
        titleLabel.style = .primaryMedium16
        errorLabel.style = .errorMedium12
        formFieldView.layer.cornerRadius = 5
        formFieldView.backgroundColor = CustomColors.formFieldBackgroundColor
    }
    func loadData() {
        titleLabel.text = data?.title
        selectedTitleLabel.text = data?.selectedTitle
        if (data?.errorMessage) != nil {
            showError()
        } else{
            hideError()
        }
    }
    func showError(){
        formFieldView.layer.borderWidth = 1
        formFieldView.layer.borderColor = CustomColors.errorColor.cgColor
        errorLabel.text = errorMessage ?? data?.errorMessage
    }
    func hideError() {
        formFieldView.layer.borderWidth = 0
        formFieldView.layer.borderColor = UIColor.clear.cgColor
        errorLabel.text = ""
    }
    @IBAction func optionsButtonAction(_ sender: Any) {
        delegate?.didSelectShowOptions(type: data?.type, requiredField: data?.requiredField)
    }
}
