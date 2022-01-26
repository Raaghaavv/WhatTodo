//
//  TodoListView.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    private let todos: [TodoData]
    @State var isPresented = false
    
    init(todos: [TodoData]) {
        self.todos = todos
    }
    
    var body: some View {
        NavigationView {
            List(todos) { todo in
                NavigationLink {
                    TodoDescriptionView(detailData: todo)
                } label: {
                    TodoListRowView(todo: todo)
                }
            }
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
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todos: [])
    }
}
