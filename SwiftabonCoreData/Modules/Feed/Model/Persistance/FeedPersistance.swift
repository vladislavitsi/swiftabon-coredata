//
//  FeedPersistance.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/14/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

protocol FeedPersistence : class, FeedPersistenceOut {
    // Read
    func record(forIndexPath: IndexPath) -> Record
    var numberOfRecords: Int { get }
    // Update
    func update()
    // Delete
    func clearData()
}

protocol FeedPersistenceOut {
    var willChangeContent: (() -> Void)? { get set }
    var didChangeContent: (() -> Void)? { get set }
    var didInsertObject: ((IndexPath) -> Void)? { get set }
    var didRemoveObject: ((IndexPath) -> Void)? { get set }
}
