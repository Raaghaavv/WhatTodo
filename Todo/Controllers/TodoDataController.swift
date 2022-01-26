//
//  TodoDataController.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import Foundation


struct TodoDataController {
    //load from database
    
    
    func loadTodo() -> [TodoData] {
        
        let userDefault = UserDefaults.standard
        let decoder = PropertyListDecoder()
        if let data = userDefault.data(forKey: "TodoDataKey") {
            if let todos = try? decoder.decode([TodoData].self, from: data) {
                return todos
            }
        }
        
        return []
    }
    
    func saveTodos(todos: [TodoData]) {
        let userDefault = UserDefaults.standard
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(todos) {
            userDefault.set(data, forKey: "TodoDataKey")
            
        }
        
        userDefault.synchronize()
    }
}
