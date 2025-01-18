//
//  BaseButton.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit
class BaseButton: UIButton {
    enum ButtonStyle: String {
        case primaryButton
      
    }
    
    var buttonStyle: ButtonStyle = ButtonStyle.primaryButton {
        didSet {
            switch buttonStyle {
            case .primaryButton:
                self.backgroundColor = CustomColors.primaryButtonColor
                self.layer.cornerRadius = self.frame.size.height/2
                self.setTitleColor(CustomColors.primaryButtonTitleColor, for: .normal)
                self.setTitleColor(CustomColors.primaryTextColor, for: .highlighted)
                self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            }
        }
    }
}

