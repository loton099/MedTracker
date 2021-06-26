//
//  MedicineDataSource.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 24/06/21.
//

import Foundation
import CoreData

class MedicineDataSource: MedicineFetchable {
    
    var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceManager.shared.persistentContainer.viewContext) {
        self.viewContext = context
    }
    
    func getMedicineDetailsWithPredicate(_ status: Bool, completion: @escaping (Result<[MedicationDislayable], MEError>) -> Void) {
        let fetchRequest: NSFetchRequest<MedicineDetails> = MedicineDetails.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MedicineDetails.date, ascending: false)]
        if status {
            let now = Date()
            fetchRequest.predicate = NSPredicate(
                format: "%@ <= date AND date <= %@",
                now.startOfDay as CVarArg,
                now.endOfDay as CVarArg)
          }
        do {
            let results =  try viewContext.fetch(fetchRequest)
            completion(.success(results))
        } catch let error {
            debugPrint(error)
            completion(.failure(MEError.unknownError()))
        }
    }
    
    func saveTodaysMedication() {
        let medicationDetails = MedicineDetails(date: Date())
        do {
            try medicationDetails?.managedObjectContext?.save()
            debugPrint("New medication saved")
        } catch let error  {
            debugPrint(error.localizedDescription)
        }
    }
    
    func insertMedicneDosefor(_ medicationDetails: MedicationDislayable, score: Int, timeString: String) -> ( MedicationDislayable, Bool)  {
        guard let  mediDetails =  medicationDetails as? MedicineDetails else {  return (medicationDetails ,false) }
        guard let medicineDose = DosesModel(time: timeString, score: Int16(score)) else { return (medicationDetails ,false) }
        mediDetails.addToDoses(medicineDose)
        do {
            try medicineDose.managedObjectContext?.save()
            debugPrint("New dose added")
             return (mediDetails ,true)
        } catch let error {
            debugPrint(error.localizedDescription)
             return (medicationDetails ,false)
        }
        
    }
}
