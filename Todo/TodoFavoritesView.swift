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
            List(allFavorites) { todo in
                
                NavigationLink {
                    TodoDescriptionView(detailData: todo)
                } label: {
                    TodoListRowView(todo: todo)
                }
            }
            .navigationTitle("My Favorite Todos")
             
        }
    }
}

struct TodoFavorites_Previews: PreviewProvider {
    static var previews: some View {
        TodoFavoritesView()
    }
}
