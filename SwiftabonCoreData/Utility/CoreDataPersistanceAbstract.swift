//
//  CoreDataPersistanceAbstract.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/13/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

class CoreDataPersistanceAbstract: NSObject {

    let coreDataService: CoreDataService

    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        super.init()
    }
}
