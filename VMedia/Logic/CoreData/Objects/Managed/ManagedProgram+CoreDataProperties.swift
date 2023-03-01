//
//  ManagedProgram+CoreDataProperties.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//
//

import Foundation
import CoreData


extension ManagedProgram {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProgram> {
        return NSFetchRequest<ManagedProgram>(entityName: "ManagedProgram")
    }

    @NSManaged public var startTime: String?
    @NSManaged public var length: Int32
    @NSManaged public var name: String?
    @NSManaged public var cache: ProgramsCache?
    @NSManaged public var airTime: ManagedProgramAriTime?

}

extension ManagedProgram : Identifiable {
    
    static func tvPrograms(from channels: [TvProgram], in context: NSManagedObjectContext) -> NSOrderedSet {
        let items = NSOrderedSet(array: channels.map({ program in
            let managed = ManagedProgram(context: context)
            managed.startTime = program.startTime
            managed.length = Int32(program.length)
            managed.name = program.name
            managed.airTime = ManagedProgramAriTime.managedAirTime(from: program.recentAirTime, in: context)
            return managed
        }))
        context.userInfo.removeAllObjects()
        return items
    }
    
    var tvProgram: TvProgram {
        TvProgram(startTime: startTime ?? "" , recentAirTime: airTime!.airTime, length: Int(length), name: name ?? "")
    }
}
