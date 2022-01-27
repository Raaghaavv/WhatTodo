//
//  ContentView.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

//The body is what you see on the screen
struct TodoRootView: View {
    //If the variable is an ObservedObject and is used by the body view of this struct, then it refreshs the UI
    @ObservedObject var viewModel: TodoViewModel
    
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView {
            
            
            TodoListView(todos: viewModel.allTodos)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("TODO's")
                    
                }
                .environmentObject(viewModel)
            
            TodoFavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                    
                }
                .environmentObject(viewModel)
            
            TodoCompletedView()
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Completed")
                    
                }
                .environmentObject(viewModel)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoRootView(viewModel: TodoViewModel(todos: [], controller: TodoDataController.loadTodo()))
//    }
//}
