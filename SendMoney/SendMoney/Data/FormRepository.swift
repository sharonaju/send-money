//
//  FormRepository.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import Foundation
// MARK: - AppState
struct AppState {
    var formValue: FormValue = FormValue(selectedService: nil, selectedProvider: nil, requiredFields: [])
}

// MARK: - AppAction
enum AppAction {
    case saveFormValue(FormValue)
    case updateRequiredFieldValue(RequiredFieldValue)
}

// MARK: - Reducer
func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .saveFormValue(let formValue):
        state.formValue = formValue
    case .updateRequiredFieldValue(let newFieldValue):
//        if let index = state.formValue.requiredFields?.firstIndex(where: { $0.requiredField?.id == newFieldValue.requiredField?.id }) {
//            state.formValue.requiredFields?[index] = newFieldValue
//        } else {
            state.formValue.requiredFields?.append(newFieldValue)
//        }
    }
}

final class FormRepository {
    static let shared = FormRepository()
    @Published private(set) var savedFormValues: [FormValue] = []
    
    private init() {}
    
    func saveFormValue(_ formValue: FormValue) {
//        if let index = savedFormValues.firstIndex(where: { $0.selectedService?.id == formValue.selectedService?.id }) {
//            savedFormValues[index] = formValue
//        } else {
            savedFormValues.append(formValue)
//        }
    }
    
    func getSavedFormValues() -> [FormValue] {
        return savedFormValues
    }
}

