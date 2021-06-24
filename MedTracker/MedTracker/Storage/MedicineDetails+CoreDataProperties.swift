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

extension MedicineDetails : Identifiable {

}
