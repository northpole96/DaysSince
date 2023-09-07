//
//  Todo.swift
//  Clear
//
//  Created by Rajesh Khuntia on 30/08/23.
//


import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var startingTime:Date
    var startColor:Color
    
}

class TodoList: ObservableObject {
   
    @Published var todos: [Todo] = []
    
   
   
//    var incompleteTodos: [Todo] {
//        todos.filter { !$0.isCompleted }
//    }
    
//    var completedTodos: [Todo] {
//        todos.filter { $0.isCompleted }
//    }
    
    func addTodo(title: String,date:Date,startColor:Color) {
        let newTodo = Todo(title: title,startingTime: date,startColor: startColor)
        todos.append(newTodo)
    }
    
    func deleteTodo(at index: Int) {
        guard index >= 0 && index < todos.count else { return }
        todos.remove(at: index)
        
        
    }
    
    func editTodo(at index: Int, newTitle: String,isCompleted: Bool) {
        guard index >= 0 && index < todos.count else { return }
        todos[index].title = newTitle
        

        
        
      
        
        
        
    }
    
    
    
    
//    func sortTodos() {
//        todos.sort(by: { $0.isCompleted && !$1.isCompleted })
//    }
}
