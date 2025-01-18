//
//  LoginViewModel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import Foundation


class LoginViewModel: NSObject {
    
    func validateEmail(email: String?) -> String?{
        let isEmailEmpty = email?.isEmpty ?? true
        if isEmailEmpty{
            return LocalizedString.pleaseEnterEmail.localized
        }
        let isEmailValid = email?.isValidEmail
        if isEmailValid == false{
            return LocalizedString.pleaseEnterValidEmail.localized
        }
        let validEmail = Constants.validEmail
        if email != validEmail{
            return LocalizedString.pleaseEnterCorrectEmail.localized
        }
        return nil
    }
    func validatePassword(password: String?) -> String?{
        let isPasswordEmpty = password?.isEmpty ?? true
        if isPasswordEmpty{
            return LocalizedString.pleaseEnterPassword.localized
        }
        let validPassword = Constants.validPassword
        if password != validPassword {
            return LocalizedString.pleaseEnterCorrectPassword.localized
        }
        return nil
    }
    
}
