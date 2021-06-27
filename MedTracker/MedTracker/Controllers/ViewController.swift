//
//  ViewController.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 23/06/21.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var medicineTakenButton: UIButton!
    lazy var viewModel = MedicineDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchMedicationDetails()
    }
    
    fileprivate func setupUI() {
        self.greetingsLabel.text = viewModel.greetingMessage
    }
    
    fileprivate func fetchMedicationDetails() {
        viewModel.fetchTodaysMedication()
    }
    
    //MARK:- BaseViewController  methods
    override func viewModelObject() -> BaseViewModel? {
        return viewModel
    }
    
    override func setUpViewModelCallbacks() {
        super.setUpViewModelCallbacks()
        
        guard let viewModel = viewModelObject() as? MedicineDetailsViewModel else { return }
        viewModel.requestSucceeded = {  [weak self] in
            guard let self = self else {  return }
            self.scoreLabel.text = viewModel.userScore
            self.scoreLabel.textColor = MedicineDoseHandler.shared.getScoreColorWith(value: viewModel.userScoreValue)
        }
    }
    
    @IBAction func medicineButtonDidTap(_ sender: UIButton) {
        viewModel.storerecentMedicineDetails()
    }
}

