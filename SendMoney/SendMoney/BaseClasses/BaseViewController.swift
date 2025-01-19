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
    }
    
   
    // MARK: - Listen to Language Change Notifications
    private func subscribeToLanguageChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: .languageDidChange, object: nil)
        refreshUI()
    }
    
    @objc func refreshUI() {
        self.title = LocalizedString.signin.localized
        if LocalizationManager.shared.currentLanguage == "ar" {
            // Set right-to-left (RTL) for Arabic
            self.view.semanticContentAttribute = .forceRightToLeft
        } else {
            // Set left-to-right (LTR) for other languages
            self.view.semanticContentAttribute = .forceLeftToRight
        }
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

}
