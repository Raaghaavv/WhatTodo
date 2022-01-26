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
    // @State private var userDescriptionInput: String = ""
    @State var text: String = " "
    
    let detailData: TodoData
    
    init(detailData: TodoData) {
        self.detailData = detailData
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    updateCurrentTodo()
                } label: {
                    Image(systemName: "heart.fill")
                        .renderingMode(.template)
                        .foregroundColor(detailData.isFavorite ? Color.red : Color.gray)
                }
                
                Spacer()
                
                Text("\(detailData.dueDate.simpleString())")

                
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
            
            VStack {
                Text("\(detailData.title)")
            
                Text("\(detailData.details)")
            }
            .padding()
            
            Spacer()
        }
    }
    
    private func updateCurrentTodo() {
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
}

struct TodoDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDescriptionView(detailData: TodoData(title: "Decription", isComplete: true, details: "", isFavorite: true))
    }
}
