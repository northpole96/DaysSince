//
//  DaysSinceApp.swift
//  DaysSince
//
//  Created by Rajesh Khuntia on 07/09/23.
//

import SwiftUI

@main
struct DaysSinceApp: App {
    @StateObject private var todoList = TodoList()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(todoList)
        }
    }
}
