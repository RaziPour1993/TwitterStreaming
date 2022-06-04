//
//  Parser.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/4/22.
//

import Foundation

protocol Parser {
    func parse<T: Decodable>(data: Data?)-> T?
}
