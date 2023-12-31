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
    var resets:[Date]=[]
    
}

class TodoList: ObservableObject {
   
    @Published var todos: [Todo] = [
        Todo(title: "Spider", startingTime: Date.distantPast, startColor: Color.red),
        Todo(title: "Spider", startingTime: Date.distantPast, startColor: Color.blue),
        Todo(title: "Spider", startingTime: Date.distantPast, startColor: Color.teal),
        Todo(title: "Spider", startingTime: Date.distantPast, startColor: Color.green),
        Todo(title: "Spider", startingTime: Date.distantPast, startColor: Color.yellow)
        
        
    ]
    
   
   
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
    func addReset(at index:Int ,date:Date)  {
        guard index >= 0 && index < todos.count else { return }
        todos[index].resets.append(date)
    }
    
    func deleteTodo(at index: Int) {
        guard index >= 0 && index < todos.count else { return }
        todos.remove(at: index)
        
        
    }
    
    func editTodo(at index: Int, newTitle: String) {
        guard index >= 0 && index < todos.count else { return }
        todos[index].title = newTitle
        

        
        
      
        
        
        
    }
    
    
    
    
//    func sortTodos() {
//        todos.sort(by: { $0.isCompleted && !$1.isCompleted })
//    }
}
