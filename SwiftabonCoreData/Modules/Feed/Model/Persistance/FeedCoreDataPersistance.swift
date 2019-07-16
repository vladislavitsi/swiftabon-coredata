
//  FeedCoreDataPersistance.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation
import CoreData

final class FeedCoreDataPersistance : CoreDataPersistanceAbstract {

    private lazy var fetchedResultController: NSFetchedResultsController<SWRecord> = {
        let frc = NSFetchedResultsController(fetchRequest: recordsFetchRequest, managedObjectContext: coreDataService.context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }()

    private lazy var recordsFetchRequest: NSFetchRequest<SWRecord> = {
        let fetchRequest: NSFetchRequest<SWRecord> = SWRecord.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(SWRecord.date), ascending: false, selector: #selector(NSDate.compare(_:)))]
        return fetchRequest
    }()

    override init(coreDataService: CoreDataService) {
        super.init(coreDataService: coreDataService)
        executeFetchRequest()
    }

    private func executeFetchRequest() {
        do {
            try coreDataService.context.execute(recordsFetchRequest)
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }

    // MARK: FeedPersistenceOut
    var willChangeContent: (() -> Void)?
    var didChangeContent: (() -> Void)?
    var didInsertObject: ((IndexPath) -> Void)?
    var didRemoveObject: ((IndexPath) -> Void)?
}

// MARK: Persistence

extension FeedCoreDataPersistance : FeedPersistence {

    func update() {
        try? fetchedResultController.performFetch()
    }

    func record(forIndexPath indexPath: IndexPath) -> Record {
        return fetchedResultController.object(at: indexPath).toRegular()
    }

    var numberOfRecords: Int {
        return fetchedResultController.fetchedObjects?.count ?? 0
    }

    func clearData() {
        do {
            try coreDataService.clearAllData(entities: SWRecord.self, SWUser.self)
        } catch {
            fatalError("🤯 Error clearing data \(error)")
        }
    }
}

extension FeedCoreDataPersistance: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        willChangeContent?()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath as IndexPath? else { break }
            didInsertObject?(indexPath)
        case .delete:
            guard let indexPath = indexPath as IndexPath? else { break }
            didRemoveObject?(indexPath)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didChangeContent?()
    }
}
