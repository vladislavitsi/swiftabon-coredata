//
//  TransactionHistoryTrackable+CoreData.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/16/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

// MARK: TransactionHistoryTrackable + CoreData

extension TransactionHistoryTrackable where Self: CoreDataParsable {
    func insert() {
        _ = self.saveTo(context: ServiceProvider.coreData.context)
    }

    func delete() {
        ServiceProvider.coreData.context.delete(parseToCoreData(usingContext: ServiceProvider.coreData.context))
    }
}
