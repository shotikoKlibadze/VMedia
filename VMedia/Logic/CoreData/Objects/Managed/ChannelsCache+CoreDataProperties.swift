//
//  ChannelsCache+CoreDataProperties.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//
//

import Foundation
import CoreData


extension ChannelsCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChannelsCache> {
        return NSFetchRequest<ChannelsCache>(entityName: "ChannelsCache")
    }

    @NSManaged public var date: Date?
    @NSManaged public var channels: NSOrderedSet?

}

extension ChannelsCache {
    
    static func find(in context: NSManagedObjectContext) throws -> ChannelsCache? {
        let request = NSFetchRequest<ChannelsCache>(entityName: entity().name!)
        request.returnsDistinctResults = false
        return try context.fetch(request).first
    }
    
    static func deleteCache(in context: NSManagedObjectContext) throws {
        try find(in: context).map(context.delete).map(context.save)
    }
    
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ChannelsCache {
        try deleteCache(in: context)
        return ChannelsCache(context: context)
    }
    
    var tvChannels: [TvChannel] {
        return channels?.compactMap { ($0 as? ManagedChannel)?.channel } ?? []
    }
}

// MARK: Generated accessors for channels
extension ChannelsCache {

    @objc(insertObject:inChannelsAtIndex:)
    @NSManaged public func insertIntoChannels(_ value: ManagedChannel, at idx: Int)

    @objc(removeObjectFromChannelsAtIndex:)
    @NSManaged public func removeFromChannels(at idx: Int)

    @objc(insertChannels:atIndexes:)
    @NSManaged public func insertIntoChannels(_ values: [ManagedChannel], at indexes: NSIndexSet)

    @objc(removeChannelsAtIndexes:)
    @NSManaged public func removeFromChannels(at indexes: NSIndexSet)

    @objc(replaceObjectInChannelsAtIndex:withObject:)
    @NSManaged public func replaceChannels(at idx: Int, with value: ManagedChannel)

    @objc(replaceChannelsAtIndexes:withChannels:)
    @NSManaged public func replaceChannels(at indexes: NSIndexSet, with values: [ManagedChannel])

    @objc(addChannelsObject:)
    @NSManaged public func addToChannels(_ value: ManagedChannel)

    @objc(removeChannelsObject:)
    @NSManaged public func removeFromChannels(_ value: ManagedChannel)

    @objc(addChannels:)
    @NSManaged public func addToChannels(_ values: NSOrderedSet)

    @objc(removeChannels:)
    @NSManaged public func removeFromChannels(_ values: NSOrderedSet)

}

extension ChannelsCache : Identifiable {

}
