//
//  TodoListRowView.swift
//  Todo
//
//  Created by Raghav Goswami on 1/22/22.
//

import SwiftUI

struct TodoListRowView: View {
    let todo: TodoData

    init(todo: TodoData) {
        self.todo = todo
    }
    
    var body: some View {
        HStack {
            if todo.isComplete {
                Image(systemName: "checkmark.circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.green)
            } else {
                Image(systemName: "minus.circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.yellow)
            }
            
            VStack(alignment: .leading) {
                Text("\(todo.title)")
                Text("\(todo.dueDate.simpleString())")
                    .foregroundColor(.secondary)
                    .font(Font.system(size: 12))
            }
        }
    }
}

struct TodoListRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListRowView(todo: TodoData(title: "Hi", isComplete: true, details: "Hello", isFavorite: true))
    }
}
