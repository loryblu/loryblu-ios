//
//  LocbookTask.swift
//  LoryBlu
//
//  Created by Suh on 29/11/23.
//

import UIKit

struct LocbookTask {
    var id: Int?
    var shift: String?
    var frequency: [String]?
    var order: Int?
    var categoryId: String?
    var categoryTitle: String?
    var updatedAt: Date?

    init(
        id: Int? = nil,
        shift: String? = nil,
        frequency: [String]? = nil,
        order: Int? = nil,
        categoryId: String? = nil,
        categoryTitle: String? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.shift = shift
        self.frequency = frequency
        self.order = order
        self.categoryId = categoryId
        self.categoryTitle = categoryTitle
        self.updatedAt = updatedAt
    }
}
