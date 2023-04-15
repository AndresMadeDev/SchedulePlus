//
//  SchedulePlusApp.swift
//  SchedulePlus
//
//  Created by Andres Made on 4/15/23.
//

import SwiftUI

@main
struct SchedulePlusApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
