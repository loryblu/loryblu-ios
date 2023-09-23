//
//  RequestModel.swift
//  suelencristina-fintech
//
//  Created by Suh on 07/07/23.
//

import Foundation

struct RequestModel: Request {
    var baseURL: String
    var path: String
    var method: RequestMethod
    var header: [String: String]?
    var body: [String: Any]?
}
