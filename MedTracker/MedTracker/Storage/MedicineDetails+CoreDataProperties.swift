//
//  MedicineDetails+CoreDataProperties.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 24/06/21.
//
//

import Foundation
import CoreData


extension MedicineDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicineDetails> {
        return NSFetchRequest<MedicineDetails>(entityName: "MedicineDetails")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var doses: NSSet?

}

// MARK: Generated accessors for doses
extension MedicineDetails {

    @objc(addDosesObject:)
    @NSManaged public func addToDoses(_ value: DosesModel)

    @objc(removeDosesObject:)
    @NSManaged public func removeFromDoses(_ value: DosesModel)

    @objc(addDoses:)
    @NSManaged public func addToDoses(_ values: NSSet)

    @objc(removeDoses:)
    @NSManaged public func removeFromDoses(_ values: NSSet)

}

extension MedicineDetails : Identifiable, MedicationDislayable {
   
    var score: Int16 {
        return self.dosesInfo?.reduce(0, {$0 + $1.score}) ?? 0
    }
    
    var formattedDate: String? {
        return self.date?.getFormattedDate(format: "dd/MM/yy")
    }
    
    var medicationHistoryAvailable: Bool {
        guard let doses = self.dosesInfo ,doses.count > 0 else { return false }
        return true
    }
    
    func getMedicineDosesWith(_ data: MedicineTimings) -> String {
        guard let doses = self.dosesInfo ,doses.count > 0 else { return "" }
        guard  let index = doses.first(where: {$0.medicineTakenTime!.hasPrefix(data.rawValue)}) else {
          return ""
        }
        
        guard let medicineTakenTime = index.medicineTakenTime, medicineTakenTime.count > 0 else { return "" }
        let medicineTakenArrayString = medicineTakenTime.components(separatedBy: "-")
        return medicineTakenArrayString[1]
        
    }
}
