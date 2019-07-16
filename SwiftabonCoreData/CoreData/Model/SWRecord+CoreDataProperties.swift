//
//  SWRecord+CoreDataProperties.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/17/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//
//

import Foundation
import CoreData


extension SWRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SWRecord> {
        return NSFetchRequest<SWRecord>(entityName: "SWRecord")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var user: SWUser?

}
