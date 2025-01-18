//
//  SendMoneyFormViewModel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import Foundation

protocol SendMoneyFormViewModelDelegate {
    func loadSendMoneyFormData(data: [Any]?)
}

struct RequiredFieldValue {
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
            let defaultProvider = defaultService?.providers?.first
            formInputValue.selectedProvider = defaultProvider
            createViewData()
        case .failure(let error):
            print("Error loading data: \(error.localizedDescription)")
        }
    }
    
    func createViewData() {
        var data = [Any]()
        let serviceModel = FormOptionsViewModel(title: LocalizedString.services.localized, selectedTitle: formInputValue.selectedService?.label?.en, type: .service)
        let serviceTableViewCellModel = FormOptionsTableViewCellModel(formOptionModel: serviceModel)
        data.append(serviceTableViewCellModel)
        let providerModel = FormOptionsViewModel(title: LocalizedString.providers.localized, selectedTitle: formInputValue.selectedProvider?.name, type: .provider)
        let providerTableViewCellModel = FormOptionsTableViewCellModel(formOptionModel: providerModel)
        data.append(providerTableViewCellModel)
        if let requiredFields = formInputValue.selectedProvider?.requiredFields{
            for item in requiredFields {
                if let type = item.type {
                    switch type {
                    case .msisdn:
                        let title = item.label?.en
                        let placeHolder = item.placeholder?.en
                        let fieledModel = FormTextFieldViewModel(title: title, textfieldPlaceHolder: placeHolder, textFieldKeybordType: .phonePad)
                        let cellModel = FormTextFieldTableViewCellModel(formTextFieldModel: fieledModel)
                        data.append(cellModel)
                    case .number:
                        let title = item.label?.en
                        let placeHolder = item.placeholder?.en
                        let fieledModel = FormTextFieldViewModel(title: title, textfieldPlaceHolder: placeHolder, textFieldKeybordType: .numberPad)
                        let cellModel = FormTextFieldTableViewCellModel(formTextFieldModel: fieledModel)
                        data.append(cellModel)
                    case .option:
                        let title = item.label?.en
                        let defaultOption = item.options?.first?.label
                        let optionModel = FormOptionsViewModel(title: title, selectedTitle: defaultOption, type: .requiredField)
                        let cellModel = FormOptionsTableViewCellModel(formOptionModel: optionModel)
                        data.append(cellModel)
                    case .text:
                        let title = item.label?.en
                        let placeHolder = item.placeholder?.en
                        let fieledModel = FormTextFieldViewModel(title: title, textfieldPlaceHolder: placeHolder, textFieldKeybordType: .default)
                        let cellModel = FormTextFieldTableViewCellModel(formTextFieldModel: fieledModel)
                        data.append(cellModel)
                    }
                }
            }
        }
        delegate?.loadSendMoneyFormData(data: data)
    }
    
}
