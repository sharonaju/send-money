//
//  LocalizationManager.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import Foundation

class LocalizationManager {
    
    static let shared = LocalizationManager()
    
    // Language Codes
    private let englishLanguageCode = "en"
    private let arabicLanguageCode = "ar"
    
    // Get current language
    var currentLanguage: String {
        return Locale.current.language.languageCode?.identifier ?? englishLanguageCode
    }
    
    // Set language
    func setLanguage(to languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }
    
    // Get localized string
    func localizedString(forKey key: String) -> String {
        let localizedString = NSLocalizedString(key, comment: "")
        return localizedString
    }
}

