//
//  CoreData+MO.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/14/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation
import CoreData

// MARK: User + CoreData

protocol CoreDataParsable {

    associatedtype Entity: NSManagedObject
    var uniquePredicate: NSPredicate? { get }
    func saveTo(context: NSManagedObjectContext) -> Entity
    func parseToCoreData(usingContext context: NSManagedObjectContext) -> Entity
}

extension CoreDataParsable {
    func parseToCoreData(usingContext context: NSManagedObjectContext) -> Entity {
        let fr: NSFetchRequest<Entity> = NSFetchRequest<Entity>(entityName: String(describing: Entity.self))
        fr.predicate = uniquePredicate
        fr.fetchLimit = 1
        if let object = (try? context.fetch(fr))?.first {
            return object
        } else {
            return saveTo(context: context)
        }
    }
}

// MARK: User + CoreData

extension User: CoreDataParsable {
    var uniquePredicate: NSPredicate? {
        guard let username = username else { return nil }
        return NSPredicate(format: "name = %@", username)
    }

    func saveTo(context: NSManagedObjectContext) -> SWUser {
        let user = SWUser(context: context)
        user.name = username
        return user
    }

}

// MARK: Record + CoreData

extension Record: CoreDataParsable {
    var uniquePredicate: NSPredicate? {
        return NSPredicate(format: "id = %@", id as CVarArg)
    }


    func saveTo(context: NSManagedObjectContext) -> SWRecord {
        let record = SWRecord(context: context)
        if let user = user {
            record.user = user.parseToCoreData(usingContext: context)
        }
        record.text = text
        record.date = Date()
        return record
    }
}

