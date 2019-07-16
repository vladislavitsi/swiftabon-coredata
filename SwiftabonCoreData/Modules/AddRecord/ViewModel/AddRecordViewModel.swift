//
//  AddRecordViewModel.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/5/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

protocol AddRecordViewModeling {
    func add(record: Record)
}

struct AddRecordViewModel: AddRecordViewModeling {

    let persistence: AddRecordPersistance

    func add(record: Record) {
        persistence.add(record: record)
    }
}
