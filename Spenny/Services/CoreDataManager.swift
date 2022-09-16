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
    
    let spennyDataPublisher = PassthroughSubject<SpennyData?, Error>()
    
    
    private let container: NSPersistentContainer
    
    init(){
        self.container = NSPersistentContainer(name: "SpennyModel")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("\n Error loading Core Data Stores. Error: \(error.localizedDescription) \n")
            }
        }
        
        getSpennyData()
    }
    
    
    
    // MARK: Load Spenny Entity
    func getSpennyData(){
        let request = NSFetchRequest<SpennyEntity>(entityName: "SpennyEntity")
        do {
            let result = try container.viewContext.fetch(request)
            
            guard !result.isEmpty else { spennyDataPublisher.send(nil); return }
            let spennyData = SpennyData(monthlyIncome: result[0].monthlyIncome, savingsGoal: result[0].savingsGoal, transactions: (result[0].transactions?.allObjects as! [Transaction]))
            
            spennyDataPublisher.send(spennyData)
            print("\n This is the fetched data: \(spennyData) \n")
            
        } catch{
            print("\n [CORE DATA MANAGER] --> Error fetching Spenny Data from core data. Error: \(error.localizedDescription) \n")
            spennyDataPublisher.send(nil)
        }
    }
    
    
    // MARK: Save Spenny Data
    func addSpennyData(spennyData: SpennyData){
        let spennyEntity = SpennyEntity(context: container.viewContext)
        spennyEntity.monthlyIncome = spennyData.monthlyIncome
        spennyEntity.savingsGoal = spennyData.savingsGoal
        
        for transaction in spennyData.transactions{
            
            let transactionEntity = TransactionEntity(context: container.viewContext)
            transactionEntity.spennyEntity = spennyEntity
            transactionEntity.title = transaction.title
            transactionEntity.amount = transaction.amount
            transactionEntity.id = transaction.id
            transactionEntity.date = transaction.date
            transactionEntity.isDirectDebit = transaction.isDirectDebit
            
            let transactionTypeEntity = TransactionTypeEntity(context: container.viewContext)
            transactionTypeEntity.transactionEntity = transactionEntity
            transactionTypeEntity.title = transaction.transactionType.title
            transactionTypeEntity.iconName = transaction.transactionType.iconName
            transactionTypeEntity.colorHex = transaction.transactionType.colorHex
            
            transactionEntity.transactionType = transactionTypeEntity
            
            spennyEntity.transactions?.adding(transactionEntity)
        }
        spennyEntity.transactions?.addingObjects(from: spennyData.transactions)
        applyChanges()
    }
    
    
    // MARK: Save
    private func save(){
        do {
            try container.viewContext.save()
        } catch {
            print("\n Error saving to core data. Error: \(error.localizedDescription) \n")
        }
    }
    
    
    // MARK: Save & Reload Data
    private func applyChanges(){
        save()
        getSpennyData()
    }
    
}
