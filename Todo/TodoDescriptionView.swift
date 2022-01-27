//
//  TodoDescriptionView.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

struct TodoDescriptionView: View {
    @State var isPresented = false
    @EnvironmentObject var viewModel: TodoViewModel
    @State var text: String = " "
    @State private var confirmationShown = false

    
    let detailData: TodoData
    
    init(detailData: TodoData) {
        self.detailData = detailData
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    updateCurrentFavoriteTodo()
                } label: {
                    Image(systemName: "heart.fill")
                        .renderingMode(.template)
                        .foregroundColor(detailData.isFavorite ? Color.red : Color.gray)
                }
                
                Spacer()
                
                Button {
                    updateCurrentCompletedTodo()
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(detailData.isComplete ? Color.green : Color.gray)
                }
                
                Spacer()
                
                Button(
                        role: .destructive,
                        action: { confirmationShown = true }
                    ) {
                        Image(systemName: "trash")
                    }
                
                .confirmationDialog(
                    "Are you sure?",
                     isPresented: $confirmationShown
                ) {
                    Button("Delete") {
                        withAnimation {
                            viewModel.removeTodo(todoID: detailData.id)
                        }
                    }
                
                }
                Spacer()
                
                Spacer()

                Button("Edit") {
                    isPresented = true
                }
                .sheet(isPresented: $isPresented) {
                    
                } content: {
                    TodoCreateAndEditView(todo: detailData)
                        .environmentObject(viewModel)
                }

            }
            .padding()
            
            ScrollView {
                VStack {
                    Text("\(detailData.title)")
                    
                    Text("\(detailData.dueDate.simpleString())")
                
                    Text("\(detailData.details)")
                }
                .padding()
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
           
            
        }
        
        
    }
    
    private func updateCurrentFavoriteTodo() {
        let todo = TodoData(
            id: detailData.id,
            dueDate: detailData.dueDate,
            dateCompleted: detailData.dateCompleted,
            title: detailData.title,
            isComplete: detailData.isComplete,
            details: detailData.details,
            isFavorite: !detailData.isFavorite
        )
        viewModel.updateTodo(todo: todo)
    }
    
    private func updateCurrentCompletedTodo() {
        let todo = TodoData(
            id: detailData.id,
            dueDate: detailData.dueDate,
            dateCompleted: detailData.dateCompleted,
            title: detailData.title,
            isComplete: !detailData.isComplete,
            details: detailData.details,
            isFavorite: detailData.isFavorite
        )
        viewModel.updateTodo(todo: todo)
    }
}

struct TodoDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDescriptionView(detailData: TodoData(title: "Decription", isComplete: true, details: "", isFavorite: true))
    }
}
