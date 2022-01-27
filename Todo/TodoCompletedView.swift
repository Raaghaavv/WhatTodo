//
//  TodoFavorites.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

struct TodoCompletedView: View {
    @EnvironmentObject var viewModel: TodoViewModel
   
    
    var body: some View {
        

            let allFavorites = viewModel.allTodos.filter({ $0.isComplete == true })
            
        
        NavigationView {
            List {
                ForEach(allFavorites) { todo in
                    NavigationLink {
                        TodoDescriptionView(detailData: todo)
                    } label: {
                        TodoListRowView(todo: todo)
                    }
                }
                .onDelete(perform: deleteRow)
               
            }
            .navigationTitle("My Completed Todos")
             
        }
    }
    
    private func deleteRow(at offSet: IndexSet) {
        let allCompleted = viewModel.allTodos.filter({ $0.isComplete == true })
        guard let todoID = offSet.map({ allCompleted[$0].id }).first else { return }
        viewModel.removeTodo(todoID: todoID)
    }
    
}

struct TodoCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCompletedView()
    }
}
