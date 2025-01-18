//
//  LocalizedString.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import Foundation

enum LocalizedString: String {
    case signin = "signIn"
    case sendMoneyApp = "sendMoneyApp"
    case welcomeToSendMoneyApp = "welcomeToSendMoneyApp"
    case email = "email"
    case password = "password"
    case byProceedingYouAgreeToTerms = "byProceedingYouAgreeToTerms"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

