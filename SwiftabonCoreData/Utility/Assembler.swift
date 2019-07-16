//
//  Assembler.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import UIKit
import CoreData

struct Assembler {
    
    static var FeedViewController: FeedViewController? {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController else { return nil }
        let persistence = FeedCoreDataPersistance(coreDataService: ServiceProvider.coreData)
        let model = FeedModel(withPersistance: persistence, syncService: ServiceProvider.sync)
        let viewModel = FeedViewModel(with: model)
        vc.viewModel = viewModel
        return vc
    }

    static var addRecordViewController: AddRecordViewController? {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddRecordViewController") as? AddRecordViewController else { return nil }
        vc.viewModel = AddRecordViewModel(persistence: AddRecordCoreDataPersistance(coreDataService: ServiceProvider.coreData))
        return vc
    }
}
