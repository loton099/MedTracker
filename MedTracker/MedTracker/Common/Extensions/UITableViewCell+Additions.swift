//
//  UITableViewCell+Additions.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 25/06/21.
//

import Foundation
import UIKit

extension UITableViewCell {
  /// This identifier tells about the own class type
  class var identifier: String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}
