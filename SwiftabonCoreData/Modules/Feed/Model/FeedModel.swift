
//
//  FeedModel.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

protocol FeedModeling {
    func clear()
    func download()
    func upload()
    func sync()

    func record(forIndexPath indexPath: IndexPath) -> Record
    var numberOfRecords: Int { get }

    var willChangeContent: (() -> Void)? { get set }
    var didChangeContent: (() -> Void)? { get set }
    var didInsertObject: ((IndexPath) -> Void)? { get set }
    var didRemoveObject: ((IndexPath) -> Void)? { get set }
}

class FeedModel {

    var persistence: FeedPersistence
    let syncService: SyncService

    init(withPersistance persistance: FeedPersistence, syncService: SyncService) {
        self.persistence = persistance
        self.syncService = syncService
    }

    var willChangeContent: (() -> Void)? {
        didSet { persistence.willChangeContent = willChangeContent }
    }

    var didChangeContent: (() -> Void)?  {
        didSet { persistence.didChangeContent = didChangeContent }
    }

    var didInsertObject: ((IndexPath) -> Void)? {
        didSet { persistence.didInsertObject = didInsertObject }
    }

    var didRemoveObject: ((IndexPath) -> Void)? {
        didSet { persistence.didRemoveObject = didRemoveObject }
    }
}

extension FeedModel : FeedModeling {
    func sync() {
        syncService.sync()
    }

    func download() {
        syncService.download()
    }

    func upload() {
        syncService.upload()
    }

    func clear() {
        persistence.clearData()
    }

    func record(forIndexPath indexPath: IndexPath) -> Record {
        return persistence.record(forIndexPath: indexPath)
    }

    var numberOfRecords: Int {
        return persistence.numberOfRecords
    }
}
