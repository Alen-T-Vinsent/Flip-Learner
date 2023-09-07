//
//  DataController.swift
//  Flip Learner
//
//  Created by Apple  on 05/06/23.
//



import CoreData

class DataController: ObservableObject {
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    let container = NSPersistentContainer(name: "FlipLearnerLocalDB")
}
