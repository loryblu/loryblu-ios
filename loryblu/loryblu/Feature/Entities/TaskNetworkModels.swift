//
//  NetworkModels.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 15/02/24.
//

struct NetworkDataModel : Decodable {
    var study: [TasksNetworkModel]
    var routine: [TasksNetworkModel]
}

struct TasksNetworkModel : Decodable {
    var childrenId: Int
    var shift: String
    var frequency: [String]
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}
