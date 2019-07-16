//
//  CoreDataHelper.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/14/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataHelper {

    let persistenceContainer: NSPersistentContainer

    init(persistenceContainer: NSPersistentContainer) {
        self.persistenceContainer = persistenceContainer
    }

    var viewContext: NSManagedObjectContext {
        return persistenceContainer.viewContext
    }

    func saveContext () {
        DispatchQueue.main.async {
            if self.viewContext.hasChanges {
                do {
                    try self.viewContext.save()
                } catch {
                    fatalError("Unresolved error \(error)")
                }
            }
        }
    }
}
