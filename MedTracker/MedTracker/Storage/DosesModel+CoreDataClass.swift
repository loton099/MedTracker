//
//  DosesModel+CoreDataClass.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 24/06/21.
//
//

import Foundation
import CoreData

@objc(DosesModel)
public class DosesModel: NSManagedObject {
    
    convenience init?(time: String, score: Int16) {
        self.init(entity: DosesModel.entity(), insertInto: PersistenceManager.shared.persistentContainer.viewContext)
        self.medicineTakenTime = time
        self.score = score
    }
}
