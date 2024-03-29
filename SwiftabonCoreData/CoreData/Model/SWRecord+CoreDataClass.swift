//
//  SWRecord+CoreDataClass.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/17/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SWRecord)
public class SWRecord: NSManagedObject, RegularParsable {
    func toRegular() -> Record {
        let id = self.id ?? UUID()
        return Record(id: id, user: user?.toRegular(), text: text, date: date)
    }
}
