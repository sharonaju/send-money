//
//  SendMoneyData.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import Foundation

// MARK: - SendMoney
struct SendMoney: Codable {
    let title: Title?
    let services: [Service]?
}
// MARK: - Service
struct Service: Codable {
    let label: Label?
    let name: String?
    let providers: [Provider]?
}
// MARK: - Label
struct Label: Codable {
    let en: String?
}

// MARK: - Provider
struct Provider: Codable {
    let name, id: String?
    let requiredFields: [RequiredField]?

    enum CodingKeys: String, CodingKey {
        case name, id
        case requiredFields = "required_fields"
    }
}
// MARK: - RequiredField
struct RequiredField: Codable, Equatable {
    let label: Title?
    let name: String?
    let placeholder: Title?
    let type: TypeEnum?
    let validation: String?
    let maxLength: Int?
    let validationErrorMessage: Title?
    let options: [Option]?

    enum CodingKeys: String, CodingKey {
        case label, name, placeholder, type, validation
        case maxLength = "max_length"
        case validationErrorMessage = "validation_error_message"
        case options
    }
}
// MARK: - Title
struct Title: Codable, Equatable {
    let en, ar: String?
}

// MARK: - Option
struct Option: Codable, Equatable {
    let label, name: String?
}

enum TypeEnum: String, Codable, Equatable {
    case msisdn = "msisdn"
    case number = "number"
    case option = "option"
    case text = "text"
}

enum Validation: String, Codable {
    case aZaZ09164 = "^[A-Za-z0-9 ]{1,64}$"
    case empty = ""
    case sS = "^[\\s\\S]*"
    case the1909614 = "^\\+?[1-9][0-9]{6,14}$"
    case the1920D201910201912D301 = "^(?:19|20)\\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01])$"
}
