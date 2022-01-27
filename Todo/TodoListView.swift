//
//  TodoListView.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    private var todos: [TodoData]
    @State var isPresented = false
    
    init(todos: [TodoData]) {
        self.todos = todos
    }
    
    var body: some View {
        NavigationView {
            List {
                if todos.isEmpty {
                    Text("Welcome to WhatTodo! Here, you can manage your stressful needs into this easy to use app. Press the heart icon to put that todo in your favorites. Press the checkmark to confirm you have completed the todo. In order to delete, either swipe left on the todo tab or press delete inside the todo itself. Very managable to use. To get started, press the 'Create' button.  ")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(todos) { todo in
                        NavigationLink {
                            TodoDescriptionView(detailData: todo)
                        } label: {
                            TodoListRowView(todo: todo)
                        }
                    }
                    .onDelete(perform: deleteRow)
                }
                
            }
            .listStyle(.sidebar)
            .navigationTitle("My Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        isPresented = true
                    }
                    .sheet(isPresented: $isPresented) {
                        
                    } content: {
                        TodoCreateAndEditView(todo: TodoData())
                            .environmentObject(viewModel)
                    }
                }
            }
            
        }
                
    }
    
    private func deleteRow(at offSet: IndexSet) {
        
        guard let todoID = offSet.map({ todos[$0].id }).first else { return }
        viewModel.removeTodo(todoID: todoID)
    }
    
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todos: [])
    }
}
