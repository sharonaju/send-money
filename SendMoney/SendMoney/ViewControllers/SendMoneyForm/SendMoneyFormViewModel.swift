//
//  SendMoneyFormViewModel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

protocol SendMoneyFormViewModelDelegate {
    func loadSendMoneyFormData(data: [Any]?, isValidData: Bool?)
}

struct RequiredFieldValue: Equatable {
    var requiredField: RequiredField?
    var valueString: String?
    var valueOption: Option?
}

struct FormValue {
    var selectedService: Service?
    var selectedProvider: Provider?
    var requiredFields: [RequiredFieldValue]?
}

class SendMoneyFormViewModel {
    
    var delegate: SendMoneyFormViewModelDelegate?
    var sendMoneyData: SendMoney?
    var formInputValue = FormValue()
    
    func fetchFormData() {
       let result = ServiceDataManager.shared.loadJSONFromFile(fileName: "sendMoney", type: SendMoney.self)
        switch result {
        case .success(let successData):
            sendMoneyData = successData
            let defaultService = successData.services?.first
            formInputValue.selectedService = defaultService
            formInputValue.selectedProvider = nil
            createViewData(shouldValidateForm: false)
        case .failure(let error):
            print("Error loading data: \(error.localizedDescription)")
        }
    }
    
    func createViewData(shouldValidateForm: Bool?){
        var data = [Any]()
        var isValid: Bool?
        let serviceModel = FormOptionsViewModel(title: LocalizedString.services.localized, selectedTitle: formInputValue.selectedService?.label?.en, type: .service)
        let serviceTableViewCellModel = FormOptionsTableViewCellModel(formOptionModel: serviceModel)
        data.append(serviceTableViewCellModel)
        let providerName = formInputValue.selectedProvider?.name ?? LocalizedString.pleaseSelectProvider.localized
        let providerModel = FormOptionsViewModel(title: LocalizedString.providers.localized, selectedTitle: providerName, type: .provider)
        let providerTableViewCellModel = FormOptionsTableViewCellModel(formOptionModel: providerModel)
        data.append(providerTableViewCellModel)
        if let requiredFields = formInputValue.requiredFields{
            for item in requiredFields {
                if let type = item.requiredField?.type {
                    switch type {
                    case .msisdn, .number, .text:
                        let currentLangauge = LocalizationManager.shared.currentLanguage
                        let title = currentLangauge == "en" ? item.requiredField?.label?.en : item.requiredField?.label?.ar
                        let placeHolder = currentLangauge == "en" ? item.requiredField?.placeholder?.en : item.requiredField?.placeholder?.ar
                        var validationMessage: String?
                        if shouldValidateForm == true {
                            validationMessage = getValidationMessageForString(formInput: item)
                        }
                        let fieledModel = FormTextFieldViewModel(title: title, textfieldPlaceHolder: placeHolder, textFieldKeybordType: nil, textFieldValue: item.valueString, requiredField: item, type: .form, errorMessage: validationMessage)
                        let cellModel = FormTextFieldTableViewCellModel(formTextFieldModel: fieledModel)
                        if validationMessage != nil{
                            isValid = false
                        }
                        data.append(cellModel)
                    case .option:
                        var currentItem = item
                        if currentItem.valueOption == nil{
                            let defaultOption = item.requiredField?.options?.first
                            let requiredFieldValue = RequiredFieldValue(requiredField: item.requiredField, valueString: nil, valueOption: defaultOption)
                            updateRequiredFieldValue(reqFieldValue: requiredFieldValue)
                            currentItem = requiredFieldValue
                        }
                        let currentLangauge = LocalizationManager.shared.currentLanguage
                        let title = currentLangauge == "en" ? currentItem.requiredField?.label?.en : currentItem.requiredField?.label?.ar
                        let selectedOption = currentItem.valueOption?.label
                        var validationMessage: String?
                        if shouldValidateForm == true {
                            validationMessage = getValidationMessageForOption(formInput: currentItem)
                        }
                        let optionModel = FormOptionsViewModel(title: title, selectedTitle: selectedOption ?? "Please select", type: .requiredField, requiredField: currentItem, errorMessage: validationMessage)
                        let cellModel = FormOptionsTableViewCellModel(formOptionModel: optionModel)
                        if validationMessage != nil{
                            isValid = false
                        }
                        data.append(cellModel)
                    }
                }
            }
        }
        delegate?.loadSendMoneyFormData(data: data, isValidData: isValid)
    }
    
    func serviceOptions() -> [Service]?{
        let services = sendMoneyData?.services
        return services
    }
    func providerOptions() -> [Provider]? {
        let providers = formInputValue.selectedService?.providers
        return providers
    }
    func requiredOptions(requiredField: RequiredField?) -> [Option]? {
        let options = requiredField?.options
        return options
    }

    func updateRequiredFieldValue(reqFieldValue: RequiredFieldValue) {
        if let index = formInputValue.requiredFields?.firstIndex(where: { $0.requiredField == reqFieldValue.requiredField }) {
            // If RequiredFieldValue exists, update the object at that index
            formInputValue.requiredFields?[index] = reqFieldValue
        }
    }
    func getValidationMessageForString(formInput: RequiredFieldValue) -> String?{
        var validationMessge: String?
        if let errorMessage = formInput.requiredField?.validationErrorMessage{
            if let validation = formInput.requiredField?.validation, validation.count > 0 {
                if let input = formInput.valueString, input.trimmingCharacters(in: .whitespaces).count > 0 {
                    let isValidInput = input.validateForm(regex: validation)
                    if isValidInput == false {
                        let currentLangauge = LocalizationManager.shared.currentLanguage
                        validationMessge = (currentLangauge == "en") ? errorMessage.en : errorMessage.ar
                    }
                    if let maxLength = formInput.requiredField?.maxLength {
                        if formInput.valueString?.count ?? 0 > maxLength {
                            let currentLangauge = LocalizationManager.shared.currentLanguage
                            validationMessge = (currentLangauge == "en") ? errorMessage.en : errorMessage.ar
                        }
                    }
                } else{
                    let currentLangauge = LocalizationManager.shared.currentLanguage
                    validationMessge = (currentLangauge == "en") ? errorMessage.en : errorMessage.ar
                }
                
            } else{
                if formInput.valueString == nil {
                    let currentLangauge = LocalizationManager.shared.currentLanguage
                    validationMessge = (currentLangauge == "en") ? errorMessage.en : errorMessage.ar
                }
            }
        }
        
        return validationMessge
    }
    func getValidationMessageForOption(formInput: RequiredFieldValue) -> String?{
        var validationMessge: String?
        if let errorMessage = formInput.requiredField?.validationErrorMessage{
            if formInput.valueOption == nil{
                let currentLangauge = LocalizationManager.shared.currentLanguage
                validationMessge = (currentLangauge == "en") ? errorMessage.en : errorMessage.ar
            }
        }
        
        return validationMessge
    }
    
}
