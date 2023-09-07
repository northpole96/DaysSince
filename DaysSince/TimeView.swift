//
//  TimeView.swift
//  Days Since
//
//  Created by Rajesh Khuntia on 01/09/23.
//

import SwiftUI

struct TimeView: View {
    @State private var selectedTime = Date()
    @State private var timeDifference = TimeInterval(0)
    
    var body: some View {
        VStack {
            DatePicker("Select a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
            Text("Time Difference: \(formattedTimeDifference)")
                .font(.headline)
                .padding()
            
            Button(action: calculateTimeDifference) {
                Text("Start")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private var formattedTimeDifference: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timeDifference) ?? "N/A"
    }
    
    private func calculateTimeDifference() {
        let currentCalendar = Calendar.current
        let currentDate = Date()
        
        let components = currentCalendar.dateComponents([.hour, .minute], from: currentDate, to: selectedTime)
        if let hour = components.hour, let minute = components.minute {
            timeDifference = TimeInterval(hour * 3600 + minute * 60)
        }
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
