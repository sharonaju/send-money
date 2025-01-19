//
//  SendMoneyFormModel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import Foundation

struct RequiredFieldValue: Equatable, Codable {
    var requiredField: RequiredField?
    var valueString: String?
    var valueOption: Option?
}

struct FormValue: Equatable, Codable {
    var selectedService: Service?
    var selectedProvider: Provider?
    var requiredFields: [RequiredFieldValue]?
}
