//
//  SyncService.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/15/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

class SyncService {

    private let transactionHistory: TransactionHistoryService
    private let networkService: NetworkService
    private let transactionProcessor: IncomingTransactionProcessor
    private let configService: ConfiguratesService
    private let coreDataService: CoreDataService

    init(_ transactionHistory: TransactionHistoryService, _ networkService: NetworkService, _ transactionProcessor: IncomingTransactionProcessor, _ configService: ConfiguratesService, _ coreDataService: CoreDataService) {
        self.transactionHistory = transactionHistory
        self.networkService = networkService
        self.transactionProcessor = transactionProcessor
        self.configService = configService
        self.coreDataService = coreDataService
    }

    func upload() {
        DispatchQueue.global(qos: .utility).async { [unowned transactionHistory, unowned networkService] in
            let transactions = transactionHistory.fetchHistory()
            networkService.push(transactions: transactions)
        }
    }

    func download() {
        DispatchQueue.global(qos: .background).async { [weak networkService, weak configService] in
            let lastSyncDate = configService?.lastSyncDate
            networkService?.fetchTransactions(from: lastSyncDate) { [weak self] transactions in
                self?.apply(transactions: transactions)
                self?.configService.lastSyncDate = Date()
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
        group.notify(queue: .main) { [weak transactionHistory, weak coreDataService] in
            coreDataService?.saveContext()
            transactionHistory?.isEnabled = true
        }
    }

    func sync() {
        download()
        upload()
    }
}
