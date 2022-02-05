//
//  TodoCreateOrUpdateView.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

struct TodoCreateAndEditView: View {
    @State var editTitle: String = ""
    @State var editDescription: String = ""
    @State var editDueDate: String = ""
    
    @EnvironmentObject var viewModel: TodoViewModel
    @Environment(\.colorScheme) var colorScheme
    
    
    @Environment(\.presentationMode) var presentationMode

    let todo: TodoData
    let isCreating: Bool
    
    init(todo: TodoData, isCreating: Bool) {
        self.todo = todo
        self.isCreating = isCreating
    }
    
    var body: some View {

        VStack(spacing: 15) {
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                    Button(currentSaveTitle) {
                        
                        let t = TodoData(
                            id: todo.id,
                            dueDate: todo.dueDate,
                            dateCompleted: todo.dateCompleted,
                            title: editTitle,
                            isComplete: todo.isComplete,
                            details: editDescription,
                            isFavorite: todo.isFavorite
                        )
                        
                        viewModel.updateTodo(todo: t)

                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(editTitle.isEmpty || editDescription.isEmpty)
                }
            
  
        
                    
                VStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Title")
                    
                        TextField("", text: $editTitle)
                        .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(currentBorderColor, lineWidth: 0.5)
                                )
                           // .frame(height: 30, alignment: .leading)
                            .lineLimit(1)
                    }
               
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Description")
                    
                        TextEditor(text: $editDescription)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(currentBorderColor, lineWidth: 0.5)
                                    
                                )
                            .frame(maxHeight: .infinity, alignment: .leading)
                    }
                    
                    
                    
                }
               
    
                
            // Create two text fields and one date
           
            }
            .padding()
        
            .onAppear {
                self.editTitle = todo.title
                self.editDescription = todo.details
//                self.editDueDate = todo.editDueDate
            }
            
        
    }
     
    private var currentBorderColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var currentSaveTitle: String {
        isCreating ? "Create" : "Save"
    }
    
}

struct TodoCreateAndEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCreateAndEditView(todo: TodoData(), isCreating: false)
    }
}
