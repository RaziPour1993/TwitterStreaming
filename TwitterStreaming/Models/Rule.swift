//
//  Rule.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/2/22.
//

import Foundation

typealias Rules = [Rule]

struct Rule: Codable {
    let id: String?
    let value: String
    let tag: String
    
    enum CodingKeys: String, CodingKey {
        case id, value, tag
    }
    
    init(value: String, tag: String){
        self.value = value
        self.tag = tag
        self.id = nil
    }
    
}

struct RetrieveRules: Codable {
    var items: Rules
    
    enum CodingKeys: String, CodingKey {
        case items = "data"
    }
    
    init() {
        self.items = []
    }
}


