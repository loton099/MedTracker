//
//  MedicationDisplayable.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 25/06/21.
//

import Foundation

protocol MedicationDislayable {
    var id: UUID? { get }
    var date: Date? { get }
    var score: Int16 { get }
    var formattedDate: String? { get }
    var medicationHistoryAvailable: Bool { get }
    
    func getMedicineDosesWith(_ data: MedicineTimings) -> String
}
