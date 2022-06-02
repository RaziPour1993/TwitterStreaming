//
//  DeleteRules.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/2/22.
//

import Foundation

struct DeleteRules: Codable {
    var values: [String] = []
    
    init(rules: Rules) {
        rules.forEach { item in
            values.append(item.value)
        }
    }
    
}
