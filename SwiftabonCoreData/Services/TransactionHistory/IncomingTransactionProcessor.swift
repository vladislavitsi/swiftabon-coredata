//
//  IncomingTransactionProcessor.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/13/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

class IncomingTransactionProcessor {

    let queue = DispatchQueue(label: "IncomingTransactionProcessorQueue")

    func process(transaction: Transaction<TransactionHistoryTrackable>, completion: @escaping () -> ()) {
        queue.async {
            switch transaction.action {
            case .insert:
                transaction.object.insert()
            case .delete:
                transaction.object.delete()
                break
            case .update:
                fatalError("Hasn't been implemented yet!")
            }
            completion()
        }
    }
    
}
