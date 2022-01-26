//
//  TodoApp.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

@main
struct TodoApp: App {
    private let controller = TodoDataController()
    
    var body: some Scene {
        WindowGroup {
            let todoData = controller.loadTodo()
            let viewModel = TodoViewModel(todos: todoData, controller: controller)
            TodoRootView(viewModel: viewModel)
        }
    }
}
