//
//  TransactionListener.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/13/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation
import CoreData

final class TransactionListener {
    static func listen<T: NSManagedObject & RegularParsable>(to type: T.Type,_ listener: @escaping (Transaction<TransactionHistoryTrackable>) -> ()) -> AnyObject {
        return CoreDataTransaction.subscribeToTransactions(from: ServiceProvider.coreData.context, forEvents: [.insert, .delete], objectType: T.self) { transaction in
            listener(Transaction(action: transaction.action, object: transaction.object.toRegular(), dateStamp: transaction.dateStamp))
        }
    }
}
