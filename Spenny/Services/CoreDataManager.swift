//
//  CoreDataManager.swift
//  Spenny
//
//  Created by Greg Ross on 16/09/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer
    
    init(){
        self.container = NSPersistentContainer(name: "SpennyModel")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("\n Error loading Core Data Stores. Error: \(error.localizedDescription) \n")
            }
        }
    }
    
}
