//
//  MedicineHistoryViewController.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 24/06/21.
//

import UIKit

class MedicineHistoryViewController: BaseViewController {
    
    @IBOutlet weak var medicationHistoryTableView: UITableView!
    lazy var viewModel = MedicineHistoryDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDetails()
    }
    
    fileprivate func setupUI() {
        self.medicationHistoryTableView.register(NibFiles.MedicationDetailsTableViewCell.instance, forCellReuseIdentifier: MedicationDetailsTableViewCell.identifier)
    }
    
    fileprivate func fetchDetails() {
        viewModel.fetchMedicationHistory()
    }
    
    //MARK:- BaseViewController  methods
    override func viewModelObject() -> BaseViewModel? {
        return viewModel
    }
    
    override func setUpViewModelCallbacks() {
        super.setUpViewModelCallbacks()
        
        guard let viewModel = viewModelObject() as? MedicineHistoryDetailsViewModel else { return }
        
        viewModel.requestSucceeded = {  [weak self] in
            guard let self = self else { return }
            self.medicationHistoryTableView.reloadData()
        }
        
    }
}

//MARK: TableView Delegate / Datasource methods
extension MedicineHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MedicationDetailsTableViewCell.identifier, for: indexPath) as? MedicationDetailsTableViewCell {
            cell.selectionStyle = .none
            cell.configureData(self.viewModel.itemAtIndex(indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

