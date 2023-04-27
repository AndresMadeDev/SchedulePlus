//
//  SchedulePlusApp.swift
//  SchedulePlus
//
//  Created by Andres Made on 4/15/23.
//

import SwiftUI

@main
struct SchedulePlusApp: App {
    @StateObject var datacontroller : DataController
    
    init() {
        let datacontroller = DataController()
        _datacontroller = StateObject(wrappedValue: datacontroller)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
                .environmentObject(datacontroller)
                
        }
    }
}
