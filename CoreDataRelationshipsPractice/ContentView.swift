//
//  ContentView.swift
//  CoreDataRelationshipsPractice
//
//  Created by Vivek Pattanaik on 6/17/21.
//

import SwiftUI
import CoreData



// entities
// business entity
// departmentEntity
// employmentEntity


class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreataContainer")
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
            print("Success save.")
        } catch let error {
            print("Error saving Core Data : \(error.localizedDescription)")
        }
        
    }
}

class CoreDataRelationshipViewModel : ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var businesses : [BusinessEntity] = []
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        save()
    }
    
    func save(){
        manager.save()
    }
    
}

struct ContentView: View {
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing : 20){
                    Button(action: {
                        vm.addBusiness()
                    }, label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height : 55)
                            .frame(maxWidth : .infinity)
                            .background(Color.blue.cornerRadius(10))
                    })
                }.padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
