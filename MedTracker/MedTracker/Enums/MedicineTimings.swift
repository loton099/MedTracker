//
//  MedicineTimings.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 23/06/21.
//

import Foundation
import UIKit

enum MedicineTimings: String, CaseIterable {
    
    case morning = "Morning"
    case afternoon = "AfterNoon"
    case night  = "Night"
    
    func getReminderMessageAndTime() -> (String , Int) {
        switch self {
        case .morning :
            return ("morning_reminder".localized , MedicineDoses.morningTime)
        case .afternoon:
            return ("afternoon_reminder".localized , MedicineDoses.afternoonTime)
        case .night:
            return ("night_reminder".localized , MedicineDoses.nightTime)
        }
    }
    
   
}

enum MedicineDoses {
    static let morningTime: Int = 11
    static let morningStartTime: Int = 8
    static let morningEndTime: Int = 12
    static let afternoonTime: Int = 14
    static let afternoonEndTime: Int = 17
    static let nightTime: Int = 20
    static let nightEndTime: Int = 22
}

enum MedicineScore  {
    static let morningafternoonScore: Int = 30
    static let nightScore: Int = 40
}
