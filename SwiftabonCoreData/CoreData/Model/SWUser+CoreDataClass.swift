//
//  SWUser+CoreDataClass.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/17/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SWUser)
public class SWUser: NSManagedObject, RegularParsable {
    func toRegular() -> User {
        return User(username: name)
    }
}
