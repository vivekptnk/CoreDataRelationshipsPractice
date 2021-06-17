//
//  ContentView.swift
//  CoreDataRelationshipsPractice
//
//  Created by Vivek Pattanaik on 6/17/21.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading Core Data.\(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data : \(error.localizedDescription)")
        }
        
    }
}

class CoreDataRelationshipViewModel : ObservableObject {
    let manager = CoreDataManager.instance
    
}

struct ContentView: View {
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
