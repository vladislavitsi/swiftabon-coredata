//
//  ServiceProvider.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/13/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

enum ServiceProvider {

    static var transactionHistory: TransactionHistoryService = {
        return TransactionHistoryService()
    }()

    static var coreData: CoreDataService = {
        let coreDataHelper = CoreDataHelper(persistenceContainer: AppDelegate.shared.persistentContainer)
        return CoreDataService(coreDataHelper: coreDataHelper)
    }()

    static var transactionProcessor: IncomingTransactionProcessor = {
        return IncomingTransactionProcessor()
    }()

    static var networker: NetworkService = {
        return NetworkService()
    }()

    static var sync: SyncService = {
        return SyncService(ServiceProvider.transactionHistory, ServiceProvider.networker, ServiceProvider.transactionProcessor, ServiceProvider.config, ServiceProvider.coreData)
    }()

    static var config: ConfiguratesService = {
        return ConfiguratesService(UserDefaults.standard)
    }()
}
