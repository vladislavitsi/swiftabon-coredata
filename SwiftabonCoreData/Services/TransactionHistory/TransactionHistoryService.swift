//
//  TransactionHistoryService.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/12/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

class TransactionHistoryService {

    var isEnabled: Bool = false {
        didSet {
            if isEnabled {
                bindTransactionListening()
            } else {
                retainBag.dispose()
            }
        }
    }

    var isEmpty: Bool {
        return transactionList.isEmpty
    }

    // FIFO list.
    private var transactionList = [Transaction<TransactionHistoryTrackable>]()

    private let retainBag = RetainBag()

    private func bindTransactionListening() {
        retainBag += TransactionListener.listen(to: SWRecord.self, add(transaction:))
        retainBag += TransactionListener.listen(to: SWUser.self, add(transaction:))
    }

    private let queue = DispatchQueue(label: "TransactionHistoryQueue")

    func add(transaction: Transaction<TransactionHistoryTrackable>) {
        queue.async { [weak self] in
            guard self?.isEnabled == true else { return }
            self?.transactionList.append(transaction)
        }
    }

    func fetchHistory() -> [Transaction<TransactionHistoryTrackable>]{
        var transactions = [Transaction<TransactionHistoryTrackable>]()
        queue.sync {
            transactions = transactionList
            transactionList = [Transaction<TransactionHistoryTrackable>]()
        }
        return transactions
    }
}

