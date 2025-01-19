//
//  TransferDetailViewModel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import UIKit

class TransferDetailViewModel: NSObject {
    
    var formValue = FormValue()
    func convertToJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // For pretty printed JSON
        
        do {
            let jsonData = try encoder.encode(formValue)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Error encoding object: \(error)")
            return nil
        }
    }
}
