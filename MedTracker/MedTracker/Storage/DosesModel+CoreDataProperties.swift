//
//  DosesModel+CoreDataProperties.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 24/06/21.
//
//

import Foundation
import CoreData


extension DosesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DosesModel> {
        return NSFetchRequest<DosesModel>(entityName: "DosesModel")
    }

    @NSManaged public var medicineTakenTime: String?
    @NSManaged public var score: Int16
    @NSManaged public var dateOfTaken: MedicineDetails?

}

extension DosesModel : Identifiable {

}
