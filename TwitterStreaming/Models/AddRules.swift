//
//  AddRules.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/2/22.
//

import Foundation

struct AddRules: Codable {
    let add: [Rule]
    
    init(item: Rule){
        self.add = [item]
    }
}
