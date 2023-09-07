//
//  TodoListItem.swift
//  Clear
//
//  Created by Rajesh Khuntia on 30/08/23.
//

import SwiftUI

struct TodoListItem: View {
    @EnvironmentObject private var todoList: TodoList
    @State private var isEditSheetPresented = false
    @State private var timer: Timer?

    @State var currentDate = Date()
    
    
    let todo: Todo
    
  
    
    
    var body: some View {
//        VStack(alignment:.leading){
////
//            
//            Text(todo.title)
//            Spacer()
//            Text(suitableFormat(todo: todo)).font(.caption)
////            Text(format(d:currentDate))
////            Text(format(d:todo.startingTime))
//            
//                
//            Spacer()
//        }
        VStack(){
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text("\(todo.title)")
                    Text(suitableFormat(todo: todo)).font(.caption)
                    
                }
                
                Spacer()
                
            }
            .padding()
            
            
        }
        
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        
        .background(todo.startColor)
        .cornerRadius(12)
        .onAppear(){
            startTimer()
        }
        .onDisappear(){
            stopTimer()
        }
        
        
//        .listRowSeparator(.hidden)
//        .listRowBackground(Color(hex: 0xFFC300))
        .contentShape(Rectangle())
        .onTapGesture {
            isEditSheetPresented = true
        }
        
        .sheet(isPresented: $isEditSheetPresented) {
//            EditTodoSheet(isPresented: $isEditSheetPresented, todoList: todoList, todo: todo,isComplete: $isCompleted)
            
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
    
    
    private func suitableFormat(todo:Todo)->String{
        var timeDifference=DateComponents(year: 0, month: 0, day: 0,hour: 0,minute: 0,second: 0)
       
        
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: todo.startingTime, to: currentDate)
        timeDifference = components
        
        if let year=timeDifference.year{
            if(year>0)
            {
                return "\(year) year"
            }
            
        }
        if let month=timeDifference.month{
            if(month>0)
            {
                return "\(month) month"
            }
            
        }
        if let day=timeDifference.day{
            if(day>0)
            {
                return "\(day) day"
            }
            
        }
        if let hour=timeDifference.hour{
            if(hour>0)
            {
                return "\(hour) hour"
            }
            
        }
        if let minute=timeDifference.minute{
            if(minute>0)
            {
                return "\(minute) minute"
            }
            
        }
        if let second=timeDifference.second{
            if(second>0)
            {
                return "\(second) second"
            }
            
        }
        
        
        return ""
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentDate = Date()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
}


//#Preview {
//    TodoListItem()
//}
//}
