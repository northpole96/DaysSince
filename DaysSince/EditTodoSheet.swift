//
//  EditTodoSheet.swift
//  Clear
//
//  Created by Rajesh Khuntia on 30/08/23.
//

import SwiftUI

struct EditTodoSheet: View {
    @FocusState private var isFocused:Bool
    @Binding var isPresented: Bool
    @ObservedObject var todoList: TodoList
    var todo: Todo
    @State var isConfirmationDialogueShowing=false
    

    @State private var editedTitle: String
//
    
    init(isPresented: Binding<Bool>, todoList: TodoList, todo: Todo) {
        self._isPresented = isPresented
        self.todoList = todoList
        self.todo = todo
        _editedTitle = State(initialValue: todo.title)
        

    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Todo")) {
                    TextField("Enter todo name", text: $editedTitle)
                        .focused($isFocused)
                }
                
                Section{
                    Button(action: {}){
                        HStack{
                            Spacer()
                            Text("Delete").foregroundColor(.white)
                                .font(.headline)
                            Spacer()
                        }
                        .onTapGesture {
//                            todoList.deleteTodo(at: todoIndex(todo: todo))
                            isConfirmationDialogueShowing=true
                        }
                    }
                    .confirmationDialog("Are you sure", isPresented: $isConfirmationDialogueShowing){
                        
                        Button("Delete", role:.destructive){
                            
                            todoList.deleteTodo(at: todoIndex(todo: todo))
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                }
                .listRowBackground(Color.red)
            }
            .navigationBarTitle("Edit Todo", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
//                    todoList.editTodo(at: todoIndex(todo: todo), newTitle: editedTitle,isCompleted: isComplete)
                    isPresented = false
                    print(todoList.todos)
                }.disabled(editedTitle.isEmpty)
            )
        }
        .onAppear(){
            isFocused=true
        }
    }
    
    private func todoIndex(todo: Todo) -> Int {
        guard let index = todoList.todos.firstIndex(where: { $0.id == todo.id }) else {
            fatalError("Todo not found")
        }
        return index
    }
}


//#Preview {
//    EditTodoSheet()
//}
