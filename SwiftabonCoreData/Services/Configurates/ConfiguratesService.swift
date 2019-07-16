//
//  ConfiguratesService.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/16/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

final class ConfiguratesService {

    private let userDefaults: UserDefaults

    var lastSyncDate: Date? {
        get { return userDefaults.object(forKey: Constants.lastSyncDateKey) as? Date }
        set { userDefaults.set(newValue, forKey: Constants.lastSyncDateKey) }
    }

    init(_ userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    private struct Constants {
        static let lastSyncDateKey = "lastSyncDate"

        private init() {}
    }
}
