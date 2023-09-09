//
//  ContentView.swift
//  DaysSince
//
//  Created by Rajesh Khuntia on 07/09/23.
//

import SwiftUI





struct ContentView: View {
    @EnvironmentObject private var todoList: TodoList
    @State private var isSheetPresented = false
    @State private var newTodoTitle = ""
    let col=[
    GridItem(.flexible()),
    GridItem(.flexible())
    
    
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
             
                LazyVGrid(columns: col,spacing: 10) {
                    
                    ForEach(todoList.todos) { todo in
                        //                            TodoListItem(todo: todo)
                        //                                .frame(maxWidth: .infinity)
                        //                                .frame(height: 100)
                        //                                .background(todo.startColor)
                        //                                .cornerRadius(12)
                    TodoListItem(todo: todo)
                                                        
                                                        
                    }
                        .onDelete(perform: deleteTodo)
                    
                    
                    
                }
                
                
                
                
                
            }
            .padding(10)
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        isSheetPresented=true
                    }
                    .padding()
                    
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                AddTodoSheet(isPresented: $isSheetPresented, todoList: todoList)
            }
        }
        
        .onAppear(){
            
            
            
        }
        
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            todoList.deleteTodo(at: index)
        }
    }
    
    func generateRandomDate()->Date {
        let currentDate = Date()
        let randomTimeInterval = TimeInterval.random(in: -365.0 * 24.0 * 60.0 * 60.0*3.0 ... 0.0) // Random interval for the past year
        return currentDate.addingTimeInterval(randomTimeInterval)
    }
    
    
    
}









@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
