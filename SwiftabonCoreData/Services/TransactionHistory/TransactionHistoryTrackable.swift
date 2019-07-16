//
//  TransactionHistoryTrackable.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/15/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

protocol TransactionHistoryTrackable: Codable {
    func insert()
    func delete()
}
