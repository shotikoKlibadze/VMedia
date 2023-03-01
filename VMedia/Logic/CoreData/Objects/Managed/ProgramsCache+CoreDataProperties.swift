//
//  ProgramsCache+CoreDataProperties.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//
//

import Foundation
import CoreData


extension ProgramsCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgramsCache> {
        return NSFetchRequest<ProgramsCache>(entityName: "ProgramsCache")
    }

    @NSManaged public var date: Date?
    @NSManaged public var programs: NSOrderedSet?
}

extension ProgramsCache {
    
    static func find(in context: NSManagedObjectContext) throws -> ProgramsCache? {
        let request = NSFetchRequest<ProgramsCache>(entityName: entity().name!)
        request.returnsDistinctResults = false
        return try context.fetch(request).first
    }
    
    static func deleteCache(in context: NSManagedObjectContext) throws {
        try find(in: context).map(context.delete).map(context.save)
    }
    
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ProgramsCache {
        try deleteCache(in: context)
        return ProgramsCache(context: context)
    }
    
    var tvPrograms: [TvProgram] {
        return programs?.compactMap { ($0 as? ManagedProgram)?.tvProgram } ?? []
    }
}

// MARK: Generated accessors for programs
extension ProgramsCache {

    @objc(insertObject:inProgramsAtIndex:)
    @NSManaged public func insertIntoPrograms(_ value: ManagedProgram, at idx: Int)

    @objc(removeObjectFromProgramsAtIndex:)
    @NSManaged public func removeFromPrograms(at idx: Int)

    @objc(insertPrograms:atIndexes:)
    @NSManaged public func insertIntoPrograms(_ values: [ManagedProgram], at indexes: NSIndexSet)

    @objc(removeProgramsAtIndexes:)
    @NSManaged public func removeFromPrograms(at indexes: NSIndexSet)

    @objc(replaceObjectInProgramsAtIndex:withObject:)
    @NSManaged public func replacePrograms(at idx: Int, with value: ManagedProgram)

    @objc(replaceProgramsAtIndexes:withPrograms:)
    @NSManaged public func replacePrograms(at indexes: NSIndexSet, with values: [ManagedProgram])

    @objc(addProgramsObject:)
    @NSManaged public func addToPrograms(_ value: ManagedProgram)

    @objc(removeProgramsObject:)
    @NSManaged public func removeFromPrograms(_ value: ManagedProgram)

    @objc(addPrograms:)
    @NSManaged public func addToPrograms(_ values: NSOrderedSet)

    @objc(removePrograms:)
    @NSManaged public func removeFromPrograms(_ values: NSOrderedSet)

}

extension ProgramsCache : Identifiable {

}
