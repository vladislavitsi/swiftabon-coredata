//
//  Transaction.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/10/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

struct Transaction<T> {
    let action: TransactionActionType
    let object: T
    let dateStamp: Date
}

extension Transaction: Codable where T: Codable { }

enum TransactionActionType: String, Codable {
    case insert
    case update
    case delete
}
