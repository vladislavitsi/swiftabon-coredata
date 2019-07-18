//
//  Record.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/14/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

struct Record: Codable {
    let id: UUID
    let user: User?
    let text: String?
    let date: Date?
}

extension Record: TransactionHistoryTrackable { }

extension Record: Equatable {
    static func == (lhs: Record, rhs: Record) -> Bool {
        return lhs.id == rhs.id
    }
}

