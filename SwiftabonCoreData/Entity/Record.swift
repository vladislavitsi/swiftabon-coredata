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

    init(user: User?, text: String?, date: Date?) {
        self.id = UUID()
        self.user = user
        self.text = text
        self.date = date
    }

    init(id: UUID, user: User?, text: String?, date: Date?) {
        self.id = id
        self.user = user
        self.text = text
        self.date = date
    }
}

extension Record: TransactionHistoryTrackable {
    typealias ModelType = Record
}

extension Record: Equatable {
    static func == (lhs: Record, rhs: Record) -> Bool {
        return lhs.id == rhs.id
    }
}

