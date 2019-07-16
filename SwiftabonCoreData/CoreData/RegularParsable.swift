//
//  RegularParsable.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/15/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

protocol RegularParsable {
    associatedtype M: TransactionHistoryTrackable
    func toRegular() -> M
}
