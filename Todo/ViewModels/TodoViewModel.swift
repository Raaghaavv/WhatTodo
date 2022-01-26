//
//  TodoViewModel.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import Foundation
import Combine

class TodoViewModel: ObservableObject {
    let controller: TodoDataController
    //Changing the array; published will tell change
    @Published var allTodos: [TodoData]
    
    
    
    init(todos: [TodoData], controller: TodoDataController) {
        self.allTodos = todos
        self.controller = controller
    }
    
    func updateTodo(todo: TodoData) {
        allTodos.removeAll(where: { $0.id == todo.id })
        allTodos.append(todo)
      //  allTodos = allTodos + [todo]
        controller.saveTodos(todos: allTodos)
        print(allTodos.count)
    }
    
    func removeTodo(todoID: UUID) {
        allTodos.removeAll(where: { $0.id == todoID } )
        controller.saveTodos(todos: allTodos)
    }
}
