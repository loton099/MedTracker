//
//  MedicineDoseHandler.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 26/06/21.
//

import Foundation
import UIKit

struct MedicineDoseHandler {
    static let shared = MedicineDoseHandler()
    private init() {}
    
    func getCurrentDoseDetails() -> (MedicineTimings, Int) {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            case MedicineDoses.morningStartTime ..< MedicineDoses.morningEndTime :
                return (.morning , MedicineScore.morningafternoonScore)
            case MedicineDoses.morningEndTime ..< MedicineDoses.afternoonEndTime :
                return (.afternoon , MedicineScore.morningafternoonScore)
            case MedicineDoses.afternoonEndTime ..< MedicineDoses.nightEndTime :
                return (.night , MedicineScore.nightScore)
            default:
                return (.night , MedicineScore.nightScore)
        }
    }
    
    func canTakeMedicine() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            case MedicineDoses.morningStartTime ..< MedicineDoses.nightEndTime :
                return true
            default:
                return false
        }
    }
    
    func getScoreColorWith(value: Int16) -> UIColor {
        
        switch value {
            case 0 ... 30 :
                return UIColor.red
            case 30 ... 70 :
                return UIColor.orange
            default:
                return UIColor.green
        }
    }
}
