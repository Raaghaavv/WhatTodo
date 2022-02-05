//
//  TodoFavorites.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

struct TodoFavoritesView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    
    var body: some View {
        let allFavorites = viewModel.allTodos.filter({ $0.isFavorite == true })
        
        NavigationView {
            List {
                if allFavorites.isEmpty {
                    Text("Your favorite todos will show here. Click the heart to add or remove your favorite todo.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(allFavorites) { todo in
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
            .navigationTitle("My Favorite Todos")
             
        }
    }
    
    private func deleteRow(at offSet: IndexSet) {
        let allFavorites = viewModel.allTodos.filter({ $0.isFavorite == true })
        guard let todoID = offSet.map({ allFavorites[$0].id }).first else { return }
        viewModel.removeTodo(todoID: todoID)
    }
    
}

struct TodoFavorites_Previews: PreviewProvider {
    static var previews: some View {
        TodoFavoritesView()
    }
}
