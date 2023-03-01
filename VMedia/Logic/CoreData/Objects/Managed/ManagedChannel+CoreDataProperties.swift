//
//  ManagedChannel+CoreDataProperties.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//
//

import Foundation
import CoreData


extension ManagedChannel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedChannel> {
        return NSFetchRequest<ManagedChannel>(entityName: "ManagedChannel")
    }

    @NSManaged public var orderNum: Int32
    @NSManaged public var accessNuj: Int32
    @NSManaged public var callSign: String?
    @NSManaged public var id: Int32
    @NSManaged public var cache: ChannelsCache?

}

extension ManagedChannel : Identifiable {
    
    static func tvChannels(from channels: [TvChannel], in context: NSManagedObjectContext) -> NSOrderedSet {
        let items = NSOrderedSet(array: channels.map({ channel in
            let managed = ManagedChannel(context: context)
            managed.orderNum = Int32(channel.orderNum)
            managed.accessNuj = Int32(channel.accessNum)
            managed.callSign = channel.callSign
            managed.id = Int32(channel.id)
            return managed
        }))
        context.userInfo.removeAllObjects()
        return items
    }
    
    var channel: TvChannel {
        return TvChannel(orderNum: Int(orderNum), accessNum: Int(accessNuj), callSign: callSign ?? "", id: Int(id))
    }
}
