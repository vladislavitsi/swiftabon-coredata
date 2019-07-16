//
//  FeedCoreDataPersistance.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/13/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation
import CoreData

class AddRecordCoreDataPersistance: CoreDataPersistanceAbstract, AddRecordPersistance {

    func add(record: Record) {
        _ = record.saveTo(context: coreDataService.context)
        coreDataService.saveContext()
    }

}
