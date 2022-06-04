//
//  HTTPBodyEncoding.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/4/22.
//

import Foundation

protocol HTTPBodyEncoding {
    func encode<T: Encodable>(parameters: T) -> Data?
}
