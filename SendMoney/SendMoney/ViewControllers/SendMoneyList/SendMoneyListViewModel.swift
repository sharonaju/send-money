//
//  SendMoneyListViewModel.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import Foundation
import Combine

class SendMoneyListViewModel: NSObject {
    @Published var savedFormValues: [FormValue] = []
    private var repository = FormRepository.shared
    private var cancellables = Set<AnyCancellable>()
    override init() {
        // Observe changes in the repository
        super.init()
        repository.$savedFormValues
            .sink { [weak self] values in
                self?.savedFormValues = values
            }
            .store(in: &cancellables)
    }
    
    func fetchSavedData() {
        savedFormValues = repository.getSavedFormValues()
    }
}
