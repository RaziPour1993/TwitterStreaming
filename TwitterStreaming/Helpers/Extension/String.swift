//
//  String.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localization", value: "\(self)", comment: "")
    }
    
}
