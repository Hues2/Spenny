//
//  CoreDataManager.swift
//  Spenny
//
//  Created by Greg Ross on 16/09/2022.
//

import Foundation
import CoreData
import Combine

class CoreDataManager: ObservableObject {
    
    @Published var spennyDataPublisher = PassthroughSubject<SpennyEntity?, Error>()
    
    
     let container: NSPersistentContainer
    
    init(){
        self.container = NSPersistentContainer(name: "SpennyModel")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("\n Error loading Core Data Stores. Error: \(error.localizedDescription) \n")
            }
        }

    }
    
    
    
    // MARK: Load Spenny Entity
    func getSpennyData(){
        let request = NSFetchRequest<SpennyEntity>(entityName: "SpennyEntity")
        do {
            let result = try container.viewContext.fetch(request)
            
            guard !result.isEmpty else { print("\n Result is empty. Publishing nil \n"); spennyDataPublisher.send(nil); return }

            print("\n Publishing spenny entity now \n")
            spennyDataPublisher.send(result[0])
            
        } catch{
            print("\n [CORE DATA MANAGER] --> Error fetching Spenny Data from core data. Error: \(error.localizedDescription) \n")
            spennyDataPublisher.send(nil)
        }
    }
    
    // MARK: Save & Reload Data
    func applyChanges(){
        save()
        getSpennyData()
    }
    
    
    // MARK: Save
    private func save(){
        do {
            try container.viewContext.save()
        } catch {
            print("\n Error saving to core data. Error: \(error.localizedDescription) \n")
        }
    }
    
    
    
    
}
