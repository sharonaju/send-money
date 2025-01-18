//
//  BaseTextField.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit
class BaseTextField: UITextField {
    private var maxLengths = [UITextField: Int]()
    
    enum TextFieldStyle: String {
        case primary
    }
    
    
    @IBInspectable var textFieldStyle: String = TextFieldStyle.primary.rawValue {
        didSet {
            let style = TextFieldStyle(rawValue: textFieldStyle)
            switch style {
            case .primary:
                self.backgroundColor = CustomColors.formFieldBackgroundColor
                self.font = UIFont.systemFont(ofSize: 18, weight: .medium)
                self.layer.cornerRadius = 8
                self.borderStyle = .none
                self.leftSidePadding = 12
            default:
                break
            }
        }
    }
    @IBInspectable var maxLength: Int {
        get {
            guard let l = maxLengths[self] else {
                return 100 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    @IBInspectable var leftSidePadding: Int = 17 {
        didSet {
            setLeftPaddingPoints()
        }
    }
    func setLeftPaddingPoints(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftSidePadding, height: 40))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

