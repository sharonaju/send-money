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
    case pleaseEnterEmail = "pleaseEnterEmail"
    case pleaseEnterValidEmail = "pleaseEnterValidEmail"
    case pleaseEnterCorrectEmail = "pleaseEnterCorrectEmail"
    case pleaseEnterPassword = "pleaseEnterPassword"
    case pleaseEnterCorrectPassword = "pleaseEnterCorrectPassword"
    case services = "services"
    case providers = "providers"
    case send = "send"
    var localized: String {
        return LocalizationManager.shared.localizedString(forKey: self.rawValue)
    }
}

