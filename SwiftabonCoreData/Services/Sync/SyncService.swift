//
//  SyncService.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/15/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

final class SyncService {

    private let transactionHistory: TransactionHistoryService
    private let networkService: NetworkService
    private let transactionProcessor: IncomingTransactionProcessor

    init(_ transactionHistory: TransactionHistoryService, _ networkService: NetworkService, _ transactionProcessor: IncomingTransactionProcessor) {
        self.transactionHistory = transactionHistory
        self.networkService = networkService
        self.transactionProcessor = transactionProcessor
    }

    func upload() {
        DispatchQueue.global(qos: .utility).async { [unowned transactionHistory, unowned networkService] in
            let transactions = transactionHistory.fetchHistory()
            networkService.push(transactions: transactions)
        }
    }

    func download() {
        DispatchQueue.global(qos: .background).async { [weak networkService] in
            let lastSyncDate = ServiceProvider.config.lastSyncDate
            networkService?.fetchTransactions(from: lastSyncDate) { [weak self] transactions in
                self?.apply(transactions: transactions)
                ServiceProvider.config.lastSyncDate = Date()
            }
        }
    }

    private func apply(transactions: [Transaction<TransactionHistoryTrackable>]) {
        transactionHistory.isEnabled = false
        let group = DispatchGroup()
        transactions.forEach {
            group.enter()
            transactionProcessor.process(transaction: $0) {
                group.leave()
            }
        }
        group.notify(queue: .main) { [weak transactionHistory] in
            ServiceProvider.coreData.saveContext()
            transactionHistory?.isEnabled = true
        }
    }

    func sync() {
        download()
        upload()
    }
}
