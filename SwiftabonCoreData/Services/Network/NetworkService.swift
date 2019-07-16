//
//  NetworkService.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/15/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

class NetworkService {

    private let transactions: [Transaction<TransactionHistoryTrackable>] = [
        Transaction(action: .insert, object: Record(id: UUID(), user: User(username: "person 1"), text: "HA_HA_HA", date: Date()), dateStamp: Date()),
        Transaction(action: .insert, object: Record(id: UUID(), user: User(username: "person 1"), text: "HA_HA_HA", date: Date()), dateStamp: Date()),
        Transaction(action: .insert, object: Record(id: UUID(), user: User(username: "person 1"), text: "HA_HA_HA", date: Date()), dateStamp: Date()),
        Transaction(action: .insert, object: Record(id: UUID(), user: User(username: "person 1"), text: "HA_HA_HA", date: Date()), dateStamp: Date()),
        Transaction(action: .insert, object: Record(id: UUID(), user: User(username: "person 1"), text: "HA_HA_HA", date: Date()), dateStamp: Date()),
        Transaction(action: .insert, object: Record(id: UUID(), user: User(username: "person 1"), text: "HA_HA_HA", date: Date()), dateStamp: Date()),
        Transaction(action: .insert, object: Record(id: UUID(), user: User(username: "person 1"), text: "HA_HA_HA", date: Date()), dateStamp: Date()),
    ]

    func fetchTransactions(from lastSyncDate: Date?, completion: @escaping ([Transaction<TransactionHistoryTrackable>]) -> () ) {
        completion(transactions)
    }

    func push(transactions: [Transaction<TransactionHistoryTrackable>]) {
        print("PUSH \(transactions)")
    }

}
