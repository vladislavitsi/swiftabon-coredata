//
//  User.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/14/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String?
}

extension User: Equatable { }

extension User: TransactionHistoryTrackable { }
