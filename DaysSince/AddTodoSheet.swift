//
//  AddTodoSheet.swift
//  Clear
//
//  Created by Rajesh Khuntia on 30/08/23.
//

import SwiftUI

struct AddTodoSheet: View {
    
    let colors:[Color]=[.red,.orange,.blue,.green,.pink,.yellow,.cyan,.teal,.mint,.indigo]
    @State var selectedColor = Color.red
    @State var isP2=false
    let calendar = Calendar.current
    @State var isColorPickerActive=false
    @FocusState private var isFocused:Bool
    @Binding var isPresented: Bool
    @ObservedObject var todoList: TodoList
    @State private var newTodoTitle = ""
    @State private var birthDate = Date.now
    @State private var col = Color.red
    @State private var tex :String=""
    @State private var selectedDateTime = Date()
    @State private var timeDifference=DateComponents(year: 0, month: 0, day: 0,hour: 0,minute: 0,second: 0)
    
    var maximumDateTime: Date {
        return Calendar.current.date(byAdding: .second, value: -1, to: Date()) ?? Date()
    }
    
    var body: some View {
        //        VStack {
        //            DatePicker("Select a date and time", selection: $selectedDateTime, in: ...maximumDateTime, displayedComponents: [.hourAndMinute, .date])
        //                .labelsHidden()
        //                .datePickerStyle(DefaultDatePickerStyle()) // Use a different style if needed
        //            
        //            Text("Time Difference:")
        //                .font(.headline)
        //                .padding()
        //            
        //            if let difference = timeDifference {
        //                Text("\(difference.year ?? 0) years \(difference.month ?? 0) months \(difference.day ?? 0) days \(difference.hour ?? 0) hours \(difference.minute ?? 0) minutes \(difference.second ?? 0) seconds")
        //                    .font(.headline)
        //            }
        //            
        //            Button(action: calculateTimeDifference) {
        //                Text("Start")
        //                    .font(.headline)
        //                    .padding()
        //                    .background(Color.blue)
        //                    .foregroundColor(.white)
        //                    .cornerRadius(10)
        //            }
        //        }
        
        NavigationView{
            
            List{
                
                Section{
                    
                    VStack{
                        Spacer()
                        
                        HStack(){
                            
                            VStack(alignment:.leading) {
                                
                                if let day=timeDifference.day{
                                   
                                        
                                            
                                            Text("\(day)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            Text("Days")
                                        }
                                
                            }
                            Spacer()
                            VStack(alignment:.leading){
                                
                                if let hour=timeDifference.hour{
                                    Text("\(hour)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    Text("Hours")
                                }
                                
                                
                            }
                            Spacer()
                            VStack (alignment:.leading){
                                
                                if let minute=timeDifference.minute{
                                    Text("\(minute)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    Text("Minutes")
                                }
                                
                            }

                            
                            
                        }.padding(.horizontal)
                        
                    }.frame(height: 200)
                }
                .listRowBackground(selectedColor)
                
           
                TextField("Enter todo name", text: $newTodoTitle)
                    .navigationBarTitle("Add Todo", displayMode: .inline)
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            isPresented = false
                        },
                        trailing: Button("Add") {
                            todoList.addTodo(title: newTodoTitle,date: selectedDateTime,startColor: selectedColor)
                            isPresented = false
                        }.disabled(newTodoTitle.isEmpty)
                    )
                
                
                
                DatePicker("Started on", selection: $selectedDateTime, in: ...maximumDateTime, displayedComponents: [.hourAndMinute, .date])
                
                //                                .labelsHidden()
                    .datePickerStyle(DefaultDatePickerStyle()) // Use a different style if needed
                    .onChange(of: selectedDateTime, {
                        
                        calculateTimeDifference()
                    })
//                Button("Pick a color"){
//                    
//                    isP2=true
//                }
//                .sheet(isPresented: $isP2){
//                    
//                    Text("Hello")
//                        .presentationDetents([.medium,.large])
//                }
               
                    HStack{
                        Text("Pick a color")
                        Spacer()
                        Circle()
                            .frame(width: 20,height: 20)
                            .foregroundColor(selectedColor)
                        
                        
                        
                    }
                    .onAppear(){
                        let index=Int.random(in: 0...colors.count-1)
                        selectedColor=colors[index]
                        
                    }
                    .onTapGesture {
                        withAnimation(){
                            isColorPickerActive.toggle()
                        }
                    }
                
                if(isColorPickerActive){
                    ScrollView(.horizontal,showsIndicators:false){
                        HStack(spacing: 10) {
                            ForEach(colors, id: \.self) { color in
                                Button(action: {
                                    withAnimation(){
                                        selectedColor = color}
                                    //                                print(color.description)
                                }) {
                                    if(selectedColor != color){
                                        Circle()
                                            .frame(width: 40,height:40)
                                            .foregroundColor(color)
                                    }
                                    else{
                                        Circle()
                                            .frame(width: 20,height:20)
                                            .foregroundColor(color)
                                            .padding(5)
                                            .background(Color.white)
                                            .cornerRadius(200)
                                            .padding(5)
                                            .background(color)
                                            .cornerRadius(200)
                                        
                                        
                                        
                                        
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
//End of color picker Hstack
                    
                    
                    
                    
                    
                        
                    
                }
                
            
           
            //ColorPickerView(colors: predefinedColors, selectedColor: $selectedColor)
            
        } .listStyle(InsetGroupedListStyle())
    }
    
}
    
    private func calculateTimeDifference() {
        let currentDate = Date()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDateTime, to: currentDate)
        timeDifference = components
    }
}



