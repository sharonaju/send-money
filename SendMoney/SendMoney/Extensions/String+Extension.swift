//
//  String+Extension.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import Foundation
import UIKit
extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    func safelyLimitedTo(length n: Int) -> String {
        if count <= n {
            return self
        }
        return String(Array(self).prefix(upTo: n))
    }
    func validateForm(regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
}
