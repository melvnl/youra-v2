//
//  SessionData+CoreDataProperties.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 13/04/22.
//
//

import Foundation
import CoreData


extension SessionData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessionData> {
        return NSFetchRequest<SessionData>(entityName: "SessionData")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var key: String?
    @NSManaged public var moodAfter: Float
    @NSManaged public var moodBefore: Float
    @NSManaged public var noteBody: String?
    @NSManaged public var noteTitle: String?
    @NSManaged public var restDuration: Double
    @NSManaged public var workDuration: Double
    @NSManaged public var endDate: Date?

}

extension SessionData : Identifiable {

}
