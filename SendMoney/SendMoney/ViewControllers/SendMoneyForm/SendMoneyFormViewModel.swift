//
//  SendMoneyFormViewModel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

protocol SendMoneyFormViewModelDelegate {
    func loadSendMoneyFormData(data: [Any]?)
    func didSaveDataSuccessfully()
}

class SendMoneyFormViewModel {
    
    var delegate: SendMoneyFormViewModelDelegate?
    var sendMoneyData: SendMoney?
    var formInputValue = FormValue()
    var currentLanguage = "en"
    private let repository = FormRepository.shared
    var isValidating = false
    
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
        isValidating = shouldValidateForm ?? false
        var isValid = true
        let serviceModel = FormOptionsViewModel(title: LocalizedString.services.localized, selectedTitle: formInputValue.selectedService?.label?.en, type: .service)
        let serviceTableViewCellModel = FormOptionsTableViewCellModel(formOptionModel: serviceModel)
        data.append(serviceTableViewCellModel)
        let providerName = formInputValue.selectedProvider?.name ?? LocalizedString.pleaseSelectProvider.localized
        var providerErrorMessage: String?
        if formInputValue.selectedProvider == nil && shouldValidateForm == true{
            isValid = false
            providerErrorMessage = LocalizedString.pleaseSelectProvider.localized
        }
        let providerModel = FormOptionsViewModel(title: LocalizedString.providers.localized, selectedTitle: providerName, type: .provider, errorMessage: providerErrorMessage)
        let providerTableViewCellModel = FormOptionsTableViewCellModel(formOptionModel: providerModel)
        data.append(providerTableViewCellModel)
        if let requiredFields = formInputValue.requiredFields{
            for item in requiredFields {
                if let type = item.requiredField?.type {
                    switch type {
                    case .msisdn, .number, .text:
                        let title = currentLanguage == "en" ? item.requiredField?.label?.en : item.requiredField?.label?.ar
                        let placeHolder = currentLanguage == "en" ? item.requiredField?.placeholder?.en : item.requiredField?.placeholder?.ar
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
                        let title = currentLanguage == "en" ? currentItem.requiredField?.label?.en : currentItem.requiredField?.label?.ar
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
        if shouldValidateForm == true && isValid == true{
            saveForm()
        } else{
            delegate?.loadSendMoneyFormData(data: data)
        }
    }
    
    func serviceOptions() -> [Service]?{
        let services = sendMoneyData?.services
        return services
    }
    func providerOptions() -> [Provider]? {
        let providers = formInputValue.selectedService?.providers
        return providers
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
                        validationMessge = (currentLanguage == "en") ? errorMessage.en : errorMessage.ar
                    }
                    if let maxLength = formInput.requiredField?.maxLength {
                        if formInput.valueString?.count ?? 0 > maxLength {
                            validationMessge = (currentLanguage == "en") ? errorMessage.en : errorMessage.ar
                        }
                    }
                } else{
                    validationMessge = (currentLanguage == "en") ? errorMessage.en : errorMessage.ar
                }
                
            } else{
                if formInput.valueString == nil {
                    validationMessge = (currentLanguage == "en") ? errorMessage.en : errorMessage.ar
                }
            }
        }
        
        return validationMessge
    }
    func getValidationMessageForOption(formInput: RequiredFieldValue) -> String?{
        var validationMessge: String?
        if let errorMessage = formInput.requiredField?.validationErrorMessage{
            if formInput.valueOption == nil{
                validationMessge = (currentLanguage == "en") ? errorMessage.en : errorMessage.ar
            }
        }
        return validationMessge
    }
    func saveForm() {
        repository.saveFormValue(formInputValue)
        let defaultService = sendMoneyData?.services?.first
        formInputValue.selectedService = defaultService
        formInputValue = FormValue(selectedService: defaultService, selectedProvider: nil, requiredFields: nil)
        createViewData(shouldValidateForm: false)
        delegate?.didSaveDataSuccessfully()
    }
    
    func getCurrentLanguage() -> String {
        return currentLanguage == "ar" ? "English" : "العربية"
    }
}
