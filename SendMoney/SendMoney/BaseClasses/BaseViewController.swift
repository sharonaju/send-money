//
//  BaseViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    var navBarTitle: String = "" {
        didSet {
            self.title = navBarTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupUI()
//        subscribeToLanguageChange()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = CustomColors.navigationBarColor
        appearance.titleTextAttributes = [
            .foregroundColor: CustomColors.navigationTitleColor,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        addTapGestureToHideKeyboard()
        customizeBackButton()
//        addLanguageButton()
    }
    
    // MARK: - Language
    private func addLanguageButton() {
        let languageButton = UIBarButtonItem(title: getCurrentLanguage(), style: .plain, target: self, action: #selector(languageSwitchTapped))
        languageButton.tintColor = CustomColors.navigationTitleColor
        navigationItem.rightBarButtonItem = languageButton
    }
    
    private func getCurrentLanguage() -> String {
        return Locale.current.language.languageCode?.identifier == "ar" ? "English" : "العربية"
    }
    
    @objc private func languageSwitchTapped() {
        let newLanguage = Locale.current.language.languageCode?.identifier == "ar" ? "en" : "ar"
        LocalizationManager.shared.setLanguage(to: newLanguage)
        
    }
    
    
    // MARK: - Listen to Language Change Notifications
    private func subscribeToLanguageChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: .languageDidChange, object: nil)
        refreshUI()
    }
    
    @objc private func refreshUI() {
        self.title = LocalizedString.signin.localized
        view.setNeedsLayout()
    }
    
    private func setCustomTitleView() {
        let titleLabel = UILabel()
        titleLabel.text = navBarTitle
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = CustomColors.navigationTitleColor
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    private func customizeBackButton() {
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationItem.backBarButtonItem = backButton
            navigationController?.navigationBar.tintColor = CustomColors.navigationTitleColor
        }
    private func setupUI() {
        view.backgroundColor = CustomColors.backgroundColor
    }
    
    private func addTapGestureToHideKeyboard() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            tapGesture.cancelsTouchesInView = false  // So that the gesture doesn't interfere with other controls like buttons
            view.addGestureRecognizer(tapGesture)
        }
        
        @objc private func handleTapGesture() {
            view.endEditing(true)  // This will resign the first responder (hide the keyboard)
        }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
