//
//  TodoDescriptionView.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI


struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    let action: (Bool) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Are you sure you want to delete?")
            
            HStack(spacing: 20) {
                Button("Delete") {
                    presentationMode.wrappedValue.dismiss()
                    action(true)
                }
                
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding()
        .frame(height: 300)
    }
}

struct TodoDescriptionView: View {
    @State var isPresented = false
    @EnvironmentObject var viewModel: TodoViewModel
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

                if #available(iOS 15.0, *) {
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
                } else {
                    Button {
                        confirmationShown.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .sheet(isPresented: $confirmationShown) {
                        SheetView(action: { proceed in
                            if proceed {
                                withAnimation {
                                    viewModel.removeTodo(todoID: detailData.id)
                                }
                            }
                        })
                    }
                }
                
                Spacer()

                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .renderingMode(.template)
                        .foregroundColor(Color.accentColor)
                }
                .sheet(isPresented: $isPresented) {
                    
                } content: {
                    TodoCreateAndEditView(todo: detailData, isCreating: false)
                        .environmentObject(viewModel)
                }

            }
            .padding()
            
            VStack(alignment: .center) {
                Text("\(detailData.title)")
                
                Text("\(detailData.dueDate.simpleString())")
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("\(detailData.details)")
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
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
        TodoDescriptionView(detailData: TodoData(title: "Description", isComplete: true, details: "", isFavorite: true))
    }
}
