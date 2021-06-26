//
//  MedicineHistoryViewModel.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 25/06/21.
//

import Foundation

class MedicineHistoryDetailsViewModel: BaseViewModel {
    
    //MARK: Properties
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)?
    var requestSucceeded: (() -> Void)?
    var requestEncounteredError: ((_ error: MEError?) -> Void)?
    var dataSource: MedicineFetchable
    private lazy var medications: [MedicationDislayable] = []
    
    var itemCount: Int {
        return medications.count
    }
    
    func itemAtIndex(_ index: Int) -> MedicationDislayable {
        return self.medications[index]
    }
    
    var greetingMessage: String {
        return Date().currentTimeGreetingMessage
    }
    
    init(dataSource: MedicineFetchable = MedicineDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchMedicationHistory() {
        self.requestStatusChanged?(true)
        self.dataSource.getMedicineDetailsWithPredicate(false) { [weak self]  result  in
            self?.requestStatusChanged?(false)
            guard let self = self else { return }
             switch result {
                case .success(let results):
                    self.medications = results
                    self.requestSucceeded?()
                case .failure( let error):
                    self.requestEncounteredError?(error)
            }
        }
    }
    
}
