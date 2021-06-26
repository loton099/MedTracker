//
//  MedicationDetailsTableViewCell.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 25/06/21.
//

import UIKit

class MedicationDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var medicationInfoContainerView: UIView!
    @IBOutlet weak var nightTimeLabel: UILabel!
    @IBOutlet weak var afternoonTimeLabel: UILabel!
    @IBOutlet weak var morningTimeLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var afternoonLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func configureData(_ data: MedicationDislayable) {
        self.dateLabel.text = data.formattedDate ?? ""
        self.scoreLabel.text = "\(data.score )"
        self.medicationInfoContainerView.isHidden = data.medicationHistoryAvailable ? false : true
        self.infoLabel.text = "no_medicine".localized
        self.infoLabel.isHidden = data.medicationHistoryAvailable ? true : false
        let morningInfoString =  data.getMedicineDosesWith(.morning)
         if morningInfoString.count > 0 {
            self.morningLabel.text = MedicineTimings.morning.rawValue
            self.morningTimeLabel.text = morningInfoString
        }
        let afterNoonInfoString =  data.getMedicineDosesWith(.afternoon)
         if afterNoonInfoString.count > 0 {
            self.afternoonLabel.text = MedicineTimings.afternoon.rawValue
            self.afternoonTimeLabel.text = afterNoonInfoString
        }
        let nightInfoString =  data.getMedicineDosesWith(.night)
         if nightInfoString.count > 0 {
            self.nightLabel.text = MedicineTimings.night.rawValue
            self.nightTimeLabel.text = nightInfoString
        }
    }
}
