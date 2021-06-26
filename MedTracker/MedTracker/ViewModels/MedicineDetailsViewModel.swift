//
//  MedicineDetailsViewModel.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 24/06/21.
//

import Foundation
class MedicineDetailsViewModel: BaseViewModel {
    
    //MARK: Properties
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)?
    var requestSucceeded: (() -> Void)?
    var requestEncounteredError: ((_ error: MEError?) -> Void)?
    var dataSource: MedicineFetchable
    var todaysMedicationDetails: MedicationDislayable?
    
    var greetingMessage: String {
        return Date().currentTimeGreetingMessage
    }
    
    var userScore: String {
        return "\(todaysMedicationDetails?.score ?? 0)"
    }
    init(dataSource: MedicineFetchable = MedicineDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchTodaysMedication() {
        self.requestStatusChanged?(true)
        self.dataSource.getMedicineDetailsWithPredicate(true) { [weak self]  result  in
            self?.requestStatusChanged?(false)
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if results.count == 0 {
                    debugPrint("Todays medication details have not been saved so please save todays details")
                    self.storeTodaysMedicationDetails()
                }
                else {
                    self.todaysMedicationDetails = results[0]
                    self.requestSucceeded?()
                }
                
            case .failure( let error):
                self.requestEncounteredError?(error)
            }
        }
    }
    
  private  func storeTodaysMedicationDetails() {
        self.dataSource.saveTodaysMedication()
    }
    
    
    func storerecentMedicineDetails() {
        // first Check current medicinedetails available or not
        self.requestStatusChanged?(true)
        if  self.todaysMedicationDetails != nil {
            self.requestStatusChanged?(false)
            self.checkAndInsert()
        }
        else {
            self.dataSource.getMedicineDetailsWithPredicate(true) { [weak self]  result  in
                
                guard let self = self else { return }
                self.requestStatusChanged?(false)
                switch result {
                case .success(let results):
                    if results.count > 0 {
                        self.todaysMedicationDetails = results[0]
                        self.checkAndInsert()
                    }
                    
                case .failure( let error):
                    self.requestEncounteredError?(error)
                }
            }
        }
    }
    
    
    private func canStoreDetails() -> Bool {
        return MedicineDoseHandler.shared.canTakeMedicine()
    }
    
    
    private func saveMedicineDoseDeatilsWith(_ currentMedicationDetails: MedicineDetails, _ scoreTobeUpdated: Int, _ medicitineTakenTime: String) {
        // User has not taken a single medicine check the time and store it
        
        let (updatedMedicationDetails, isDosesStored) = self.dataSource.insertMedicneDosefor(currentMedicationDetails, score: scoreTobeUpdated, timeString: medicitineTakenTime)
        if isDosesStored {
            self.todaysMedicationDetails = updatedMedicationDetails
            self.requestSucceeded?()
        }
        else {
            self.requestEncounteredError?(MEError.unknownError())
        }
    }
    
    private func checkAndInsert() {
        guard let currentMedicationDetails = self.todaysMedicationDetails as? MedicineDetails else {  return  }
        if currentMedicationDetails.dosesInfo?.count == 3 {
            // User has already taken medicine
            self.requestEncounteredError?(MEError.alert(title: "med_taken".localized, message: "med_taken_message".localized, code: 201))
            return
        }
        
        guard canStoreDetails() else {
            self.requestEncounteredError?(MEError.alert(title: "alert".localized, message: "med_time_not_started".localized, code: 301))
            return
        }
        let (medicineTobeTaken, scoreTobeUpdated) = MedicineDoseHandler.shared.getCurrentDoseDetails()
        let medicitineTakenTime = "\(medicineTobeTaken.rawValue)-\(Date().getFormattedDate(format: "h:mm a"))"
        
        if currentMedicationDetails.dosesInfo?.count == 0 {
            saveMedicineDoseDeatilsWith(currentMedicationDetails, scoreTobeUpdated, medicitineTakenTime)
            
        }
        else {
            
            if  let doses = currentMedicationDetails.dosesInfo, doses.contains(where: { ($0.medicineTakenTime!.hasPrefix(medicineTobeTaken.rawValue))}) {
                // User has already taken this dose
                self.requestEncounteredError?(MEError.alert(title: "med_taken".localized, message: "med_taken_message".localized, code: 201))
                return
            }
            else {
                saveMedicineDoseDeatilsWith(currentMedicationDetails, scoreTobeUpdated, medicitineTakenTime)
            }
            
        }
        
    }
    
}
