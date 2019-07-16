//
//  CoreDataService.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/12/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {

    private let coreDataHelper: CoreDataHelper

    init(coreDataHelper: CoreDataHelper) {
        self.coreDataHelper = coreDataHelper
    }

    var context: NSManagedObjectContext {
        return coreDataHelper.viewContext
    }

    func saveContext() {
        coreDataHelper.saveContext()
    }

    func clearAllData(entities: NSManagedObject.Type...) throws {
        let timestamp = Date()
        do {
            try clear(entities: entities)
            let historyFetchRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: timestamp)
            context.performAndWait {
                do {
                    try mergeTransactionHistory(from: historyFetchRequest, to: context)
                } catch {
                    fatalError("🤯 Error applying persistence history changes \(error)")
                }
            }
            try context.execute(NSPersistentHistoryChangeRequest.deleteHistory(before: timestamp))
        } catch {
            fatalError("🤯 Error clearing data \(error)")
        }
    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }

}

// MARK: Private Interface
extension CoreDataService {

    private func mergeTransactionHistory(from historyFetchRequest: NSPersistentHistoryChangeRequest, to context: NSManagedObjectContext) throws {
        let historyResult = try context.execute(historyFetchRequest) as? NSPersistentHistoryResult
        guard let historyTransactions = historyResult?.result as? [NSPersistentHistoryTransaction] else { return }
        historyTransactions.lazy
            .map { $0.objectIDNotification() }
            .filter { ($0.userInfo?["deleted_objectIDs"] as? Set<AnyHashable>)?.isEmpty == false }
            .forEach(context.mergeChanges(fromContextDidSave:))
    }

    private func clear(entities: [NSManagedObject.Type]) throws {
        try entities
            .map { $0.fetchRequest() }
            .map { NSBatchDeleteRequest(fetchRequest: $0) }
            .forEach {
                let _ = try context.execute($0)
        }
    }
}
