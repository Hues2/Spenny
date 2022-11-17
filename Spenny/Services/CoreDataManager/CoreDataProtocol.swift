//
//  CoreDataProtocol.swift
//  Spenny
//
//  Created by Greg Ross on 17/11/2022.
//

import Foundation
import Combine
import CoreData



protocol CoreDataProtocol{
    var spennyDataPublisher: PassthroughSubject<Result<SpennyEntity?, Error>, Never> {get set}
    var container: NSPersistentContainer {get}
    func getSpennyData()
    func save()
    func applyChanges()
    
}
