//
//  AddEmployee.swift
//  SchedulePlus
//
//  Created by Andres Made on 4/27/23.
//

import SwiftUI

struct AddEmployee: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    let day : Day
    @State private var showAlert : Bool = false
 
    @State private var name: String = ""
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var hoursScheduled: Int = 4
    
    var body: some View {
        Form {
            Section("Employee Name") {
                TextField("Enter Name", text: $name)
            }
            Section("Schedule Time") {
                DatePicker("Enter Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                DatePicker("Enter End Time", selection: $endTime, displayedComponents: .hourAndMinute)
            }
            
            Section("Total Hour Scheduled") {
                Stepper("Total Hours: \(hoursScheduled)", value: $hoursScheduled)
            }

        }
        .navigationTitle("Add Employee")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveEmployee()
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Exit") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        })
        .alert(isPresented: $showAlert) {
           Alert(title: Text("Name is empty"), message: Text("Please enter name"), dismissButton: .default(Text("OK")))
          
        }
    }
    
    func saveEmployee() {
        if self.name.isEmpty {
            self.showAlert = true
        } else {
            let employee = Employee(context: dataController.container.viewContext)
            employee.id = UUID()
            employee.name = name
            employee.startTime = startTime
            employee.endTime = endTime
            employee.hourWorked = Int16(hoursScheduled)
            dataController.save()
            self.presentationMode.wrappedValue.dismiss()
        }
      
    }
}

struct AddEmployee_Previews: PreviewProvider {
    static let dataController = DataController.preview
    static var previews: some View {
        let day = Day(context: dataController.container.viewContext)
        AddEmployee(day: day)
    }
}
