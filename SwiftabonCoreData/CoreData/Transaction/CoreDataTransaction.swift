//
//  CoreDataTransaction.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/12/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation
import CoreData

extension TransactionActionType {

    var objectsKey: String {
        switch self {
        case .insert:
            return NSInsertedObjectsKey
        case .update:
            return NSUpdatedObjectsKey
        case .delete:
            return NSDeletedObjectsKey
        }
    }
}

struct CoreDataTransaction {

    private init() {}

    private class NotificationObserverDisposer {
        let object: NSObjectProtocol
        init(_ objectToDeallocate: NSObjectProtocol) {
            self.object = objectToDeallocate
        }
        deinit {
            NotificationCenter.default.removeObserver(object)
        }
    }

    static func subscribeToTransactions<T: NSManagedObject & RegularParsable>(from context: NSManagedObjectContext, forEvents eventTypes: Set<TransactionActionType>, objectType: T.Type, listener: @escaping (Transaction<T>) -> ()) -> AnyObject {
        let subscription = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: context, queue: .main) { notification in
            guard let userInfo = notification.userInfo else { return }

            for event in eventTypes {
                guard let objects = userInfo[event.objectsKey] as? Set<NSManagedObject>, objects.isEmpty == false else { continue }
                objects.compactMap { $0 as? T }.forEach {
                    listener(Transaction(action: event, object: $0, dateStamp: Date()))
                }
            }
        }
        return NotificationObserverDisposer(subscription)
    }
}
