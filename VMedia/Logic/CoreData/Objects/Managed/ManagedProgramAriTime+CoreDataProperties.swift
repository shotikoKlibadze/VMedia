//
//  ManagedProgramAriTime+CoreDataProperties.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//
//

import Foundation
import CoreData


extension ManagedProgramAriTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProgramAriTime> {
        return NSFetchRequest<ManagedProgramAriTime>(entityName: "ManagedProgramAriTime")
    }

    @NSManaged public var id: Int32
    @NSManaged public var channelID: Int32
    @NSManaged public var program: ManagedProgram?
}

extension ManagedProgramAriTime : Identifiable {
    
    static func managedAirTime(from airTime: RecentAirTime, in context: NSManagedObjectContext) -> ManagedProgramAriTime? {
        let managed = ManagedProgramAriTime(context: context)
        managed.id = Int32(airTime.id)
        managed.channelID = Int32(airTime.channelID)
        return managed
    }
    
    var airTime: RecentAirTime {
        return RecentAirTime(id: Int(id), channelID: Int(channelID))
    }
}
