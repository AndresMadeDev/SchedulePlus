//
//  Persistence.swift
//  SchedulePlus
//
//  Created by Andres Made on 4/15/23.
//

import CoreData

class DataController: ObservableObject {
    static let shared = DataController()

    let container: NSPersistentCloudKitContainer

    init() {
        container = NSPersistentCloudKitContainer(name: "SchedulePlus")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func creatSampleSchedule() {
        let viewCotext = container.viewContext
        
        let week1 = Week(context: viewCotext)
        week1.id = UUID()
        week1.weekTitle = 1
        week1.weekStartDate = Date()
        
        
        let day1 = Day(context: viewCotext)
        day1.id = UUID()
        day1.date = Date()
        day1.week = week1
        
        let employee1 = Employee(context: viewCotext)
        employee1.id = UUID()
        employee1.name = "Full Timer"
        employee1.startTime = Date()
        employee1.endTime = Date()
        employee1.hourWorked = 8
        employee1.day = day1
        
        let employee2 = Employee(context: viewCotext)
        employee2.id = UUID()
        employee2.name = "Part Timer"
        employee2.startTime = Date()
        employee2.endTime = Date()
        employee2.hourWorked = 6
        employee2.day = day1
        
        do {
            try viewCotext.save()
        } catch  {
            fatalError("Unable to load sample data: \(error.localizedDescription)")
        }
    }
        
        func save() {
            if container.viewContext.hasChanges {
                do {
                    try container.viewContext.save()
                } catch {
                    fatalError("Unable to save: \(error.localizedDescription)")
                }
            }
        }
        
        func deleteAll() {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Day.fetchRequest()
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            _ = try? container.viewContext.execute(batchDeleteRequest)
        }
    
    static var preview: DataController = {
        let dataController = DataController()
        let viewContext = dataController.container.viewContext

        dataController.creatSampleSchedule()
        return dataController
    }()
    
}
