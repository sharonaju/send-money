//
//  ServiceDataManager.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import Foundation

class ServiceDataManager {
    
    static let shared = ServiceDataManager()
    
    private init() {}
    
    func loadJSONFromFile<T: Decodable>(fileName: String, type: T.Type) -> Result<T, Error> {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return .failure(ServiceManagerError.fileNotFound(fileName))
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}

enum ServiceManagerError: LocalizedError {
    case fileNotFound(String)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let fileName):
            return "The file '\(fileName).json' was not found in the bundle."
        }
    }
}
