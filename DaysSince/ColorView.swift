//
//  ColorView.swift
//  Days Since
//
//  Created by Rajesh Khuntia on 02/09/23.
//

import SwiftUI

struct ColorView: View {
    @State var nn=25
    let predefinedColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink,.mint,.teal,.brown]
    @State private var selectedColor: Color?
    var body: some View {
       ColorPickerView(colors: predefinedColors, selectedColor: $selectedColor)
        TestView(num: $nn)
    }
}

#Preview {
    ColorView()
}



struct ColorPickerView: View {
    let colors: [Color]
    @Binding var selectedColor: Color?

    
    var body: some View {
        Circle()
            .frame(width: 20,height: 20)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .padding(3)
            .background(.white)
            .cornerRadius(2000)
            .padding(10)
            .background(.blue)
            .cornerRadius(2000)
           
            
          
        Text("Routine")
            .padding()
            .border(.white,width: 4)
//            .background(.blue)
            .padding()
            .background(selectedColor)
            
        HStack(spacing: 10) {
            ForEach(colors, id: \.self) { color in
                Button(action: {
                    withAnimation(){
                        selectedColor = color}
                }) {
                    if(selectedColor != color){
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(color)
                            .frame(width: 40, height: 40)
                    }
                    else{
                        
                        Text("")
                            .frame(width: 22, height: 22)
//                            .border(.white,width: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white, lineWidth: 3)
                            )
                            .padding(9)
                            
                            .background(color)
                            .cornerRadius(10)
                            
                           

                        
                    }
                }
            }
        }
    }
}
struct TestView:View {
    @Binding var num:Int
    var body: some View{
        
        Button("Plus"){num+=1}
        Text("\(num)")
        Button("Minus"){num-=1}
    }
}
