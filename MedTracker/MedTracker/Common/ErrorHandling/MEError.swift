//
//  MEError.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 23/06/21.
//

import Foundation

public enum MEError: Error {
  case alert(title: String, message: String?, code: Int)
}

extension MEError: LocalizedError {
    
  public var errorDescription: String? {
    switch self {
    case .alert(_, let message, _): return message?.localized
    }
  }
  
  public var title: String {
    switch self {
    case .alert(let title,_, _): return title.localized
      
    }
  }
  
  public var code: Int? {
    switch self {
    case .alert(_, _, let code): return code
      
    }
  }
}

