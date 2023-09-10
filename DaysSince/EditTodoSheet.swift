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
                            Text("Reset").foregroundColor(.white)
                                .font(.headline)
                            Spacer()
                        }
                        .onTapGesture {
                            
                            todoList.addReset(at: todoIndex(todo: todo), date: Date.now)
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                }
                .listRowBackground(todo.startColor)
//                Section("All resets"){
//                    
//                    ForEach(todo.rests, id:\.self){ i in
//                       Text(format(d: i))
//                    }
//                    
//                    
//                }
                Section(){
                    
                    NavigationLink("All Resets", destination:ResetView(todo: todo))
                                    
                    
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
                    todoList.editTodo(at: todoIndex(todo: todo), newTitle:editedTitle)
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
    private func format(d:Date)->String{
        let dateLLCCK=DateFormatter()
        dateLLCCK.dateFormat="yyyy-MM-dd HH:mm:ss"
        return dateLLCCK.string(from: d)
        
        
    }
}


struct ResetView:View {
    var todo:Todo
    var body: some View{
        
        Form{
            ForEach(todo.resets,id:\.self){i in
                Text(format(d:i))
            }
            
            
        }
        .navigationTitle(todo.title)
    }
    
    private func format(d:Date)->String{
        let dateLLCCK=DateFormatter()
        dateLLCCK.dateFormat="yyyy-MM-dd HH:mm:ss"
        return dateLLCCK.string(from: d)
        
        
    }
}

//#Preview {
//    EditTodoSheet()
//}
