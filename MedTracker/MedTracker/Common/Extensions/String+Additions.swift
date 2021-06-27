//
//  String+Additions.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 23/06/21.
//

import Foundation

extension String {
    
 var localized: String {
        return NSLocalizedString(self, comment: self)
  }
    
  func localized(withComment comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
  }
    
}
