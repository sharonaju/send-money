//
//  BaseLabel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

class BaseLabel: UILabel {
    enum LabelStyle: Equatable {
        case primaryMedium16
        case secondaryMedium14
        case secondaryMedium12
        case errorMedium12
        case custom(font: UIFont, color: UIColor)
    }
    
    var style: LabelStyle? {
        didSet {
            if oldValue != style {
                applyStyle(style ?? .primaryMedium16)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle(style ?? .primaryMedium16)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyStyle(style ?? .primaryMedium16)
    }
    private func applyStyle(_ style: LabelStyle) {
        switch style {
        case .primaryMedium16:
            self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            self.textColor = CustomColors.primaryTextColor
        case .secondaryMedium14:
            self.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            self.textColor = CustomColors.secondaryTextColor
        case .secondaryMedium12:
            self.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            self.textColor = CustomColors.primaryTextColor
        case .errorMedium12:
            self.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            self.textColor = CustomColors.errorColor
        case .custom(let font, let color):
            self.font = font
            self.textColor = color
        }
    }
}

