//
//  Request.swift
//  suelencristina-fintech
//
//  Created by Suh on 03/07/23.
//

import Foundation

enum RequestMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

protocol Request {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}