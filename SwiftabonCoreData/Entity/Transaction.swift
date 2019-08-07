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

extension Transaction where T: Equatable {
    static func == (lhs: Transaction<T>, rhs: Transaction<T>) -> Bool {
        return lhs.action == rhs.action && lhs.object == rhs.object && lhs.dateStamp == rhs.dateStamp
    }
}

extension Transaction {
    func isEqual<U, M>(to transaction2: Transaction<U>, as type: M.Type) -> Bool where M: Equatable {
        guard self.action == transaction2.action else { return false }
        guard let castedObject1 = object as? M else { return false }
        guard let castedObject2 = transaction2.object as? M else { return false }
        return castedObject1 == castedObject2 && self.dateStamp == transaction2.dateStamp
    }
}

enum TransactionActionType: String, Codable {
    case insert
    case update
    case delete
}
