//
//  MedicineDetails+CoreDataClass.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 24/06/21.
//
//

import Foundation
import CoreData

@objc(MedicineDetails)
public class MedicineDetails: NSManagedObject {
    
    var dosesInfo : [DosesModel]? {
        return self.doses?.allObjects as? [DosesModel]
    }
    
    convenience init?(date: Date, id: UUID = UUID()) {
        self.init(entity: MedicineDetails.entity(), insertInto: PersistenceManager.shared.persistentContainer.viewContext)
        self.date = date
        self.id = id
    }
}
