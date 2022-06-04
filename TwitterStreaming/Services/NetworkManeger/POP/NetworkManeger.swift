//
//  NetworkManeger.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/4/22.
//

import Foundation

protocol NetworkManeger {
    func request(with request: NetworkRequest, completion: @escaping (Result<Data?, NetworkResponseStatus>)-> Void)
    func disconnect()
}
