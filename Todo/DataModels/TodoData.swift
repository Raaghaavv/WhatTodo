//
//  TodoModel.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import Foundation


struct TodoData: Identifiable, Codable {
    let id: UUID
    let dueDate: Date
    let dateCompleted: Date
    let title: String
    let details: String
    let isComplete: Bool
    let isFavorite: Bool
    
    init(title: String, isComplete: Bool, details: String, isFavorite: Bool) {
        self.id = UUID()
        self.dueDate = Date()
        self.dateCompleted = Date()
        self.title = title
        self.isComplete = isComplete
        self.details = details
        self.isFavorite = isFavorite
    }
    
    init(id: UUID, dueDate: Date, dateCompleted: Date, title: String, isComplete: Bool, details: String, isFavorite: Bool) {
        self.id = id
        self.dueDate = dueDate
        self.dateCompleted = dateCompleted

        self.title = title
        self.isComplete = isComplete
        self.details = details
        self.isFavorite = isFavorite
    }
    
    init() {
        self.id = UUID()
        self.dueDate = Date()
        self.dateCompleted = Date()
        self.title = ""
        self.isComplete = false
        self.details = ""
        self.isFavorite = false
        
    }

}





