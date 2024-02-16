//
//  TaskModel.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 15/02/24.
//
import Foundation

struct TaskModel {
    var uuid: UUID = UUID()
    var actionType: String
    var locbookTask: LocbookTask
}
