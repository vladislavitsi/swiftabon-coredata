//
//  SWUser+CoreDataProperties.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/17/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//
//

import Foundation
import CoreData


extension SWUser {

    @NSManaged public var name: String?
    @NSManaged public var record: NSSet?

}
