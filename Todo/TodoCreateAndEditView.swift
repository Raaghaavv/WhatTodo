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
    
    
    @Environment(\.presentationMode) var presentationMode

    let todo: TodoData
    
    init(todo: TodoData) {
        self.todo = todo
        
        
    }
    
    var body: some View {

            VStack {
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                    Button("Create") {
                        
                        let t = TodoData(id: todo.id, dueDate: editDueDate, dateCompleted: todo.dateCreated, title: editTitle, isComplete: todo.isComplete, details: editDescription, isFavorite: todo.isFavorite)
                        
                        viewModel.updateTodo(todo: t)
                        

                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    
                }
                .padding()
                Spacer()
                    
                VStack(alignment: .leading) {
                        Text("Title")
                            .padding(10)
                        TextEditor(text: $editTitle)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                                )
                            .frame(height: 30, alignment: .leading)

                            
                            .padding(10)
                        
                        Text("Decription")
                            .padding(10)
                        TextEditor(text: $editDescription)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                                    
                                )
                            .frame(height: 100, alignment: .leading)
                           

                            .padding(10)
                        
                        Spacer()
                    
                        Text("Due Date")
                            .padding(10)
                        TextEditor(text: $editDueDate)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                                    
                                )
                            .frame(height: 30, alignment: .leading)
                           

                            .padding(10)
                        
                        Spacer()
                        
                        
                    }
                
            // Create two text fields and one date
           
            }
            .onAppear {
                self.editTitle = todo.title
                self.editDescription = todo.details
                self.editDueDate = todo.editDueDate
            }
            
        
    }
}

struct TodoCreateAndEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCreateAndEditView(todo: TodoData())
    }
}
