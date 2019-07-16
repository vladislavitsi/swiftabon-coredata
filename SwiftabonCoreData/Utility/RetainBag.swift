//
//  RetainBag.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 7/13/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import Foundation

class RetainBag {
    private var bag = [AnyObject]()

    static func +=(disposeBag: RetainBag, newObject: AnyObject) {
        disposeBag.bag.append(newObject)
    }

    func dispose() {
        bag.removeAll()
    }
}
