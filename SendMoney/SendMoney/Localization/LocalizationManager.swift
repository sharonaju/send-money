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
    
    private static var customBundle: Bundle?
    
    // Get current language
    var currentLanguage: String {
        return Locale.current.language.languageCode?.identifier ?? englishLanguageCode
    }
    
    // Set language
    func setLanguage(to languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        LocalizationManager.setLanguageBundle(for: languageCode)
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }
    
    func localizedString(forKey key: String) -> String {
        guard let bundle = LocalizationManager.customBundle else {
            return NSLocalizedString(key, comment: "")
        }
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
    private static func setLanguageBundle(for languageCode: String) {
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        if let path = path {
            customBundle = Bundle(path: path)
        } else {
            customBundle = Bundle.main
        }
    }
}

extension Bundle {
    private static var bundle: Bundle!
    
    static func setLanguage(_ languageCode: String) {
        // Set the custom language in UserDefaults
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        // Reload the bundle for the new language
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        if let path = path, let languageBundle = Bundle(path: path) {
            Bundle.bundle = languageBundle
        }
    }
}
