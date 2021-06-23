//
//  Protocols.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 23/06/21.
//

import Foundation

//MARK: - Protocol to handle common callbacks of view models
protocol BaseViewModel: class {
    // Used to update the request started/ended status. can be usewd to update the activity indicator.
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)? { get set }
    // Used to inform about the error
    var requestEncounteredError: ((_ error: MEError?) -> Void)? { get set }
}
