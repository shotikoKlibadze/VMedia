//
//  CoreDataStack.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation
import CoreData

final class CoreDataStack: TvGuideLocalDataService {

    private let modelName: String
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var managedContext: NSManagedObjectContext = {
      return self.storeContainer.viewContext
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    func cache(channels: [TvChannel], date: Date, completion: @escaping (Error?) -> Void) {
        insertChannels(channels: channels, date: date, completion: completion)
    }
    
    func cache(programs: [TvProgram], date: Date, completion: @escaping (Error?) -> Void) {
        insertPrograms(programs: programs, date: date, completion: completion)
    }
    
    func fetchChannels(completion: @escaping (Result<CachedChannels, Error>) -> Void) {
        retrieveChannels(completion: completion)
    }
    
    func fetchPrograms(completion: @escaping (Result<CachedPrograms, Error>) -> Void) {
        retrievePrograms(completion: completion)
    }
    
    func deleteCachedData(completion: @escaping (Error?) -> Void) {
        deleteCache(completion: completion)
    }
    
}

private extension CoreDataStack {
    
    func insertChannels(channels: [TvChannel], date: Date, completion: @escaping (Error?) -> Void) {
        perform { context in
            do {
                let managedCache = try ChannelsCache.newUniqueInstance(in: context)
                managedCache.date = date
                managedCache.channels = ManagedChannel.tvChannels(from: channels, in: context)
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func insertPrograms(programs: [TvProgram], date: Date, completion: @escaping (Error?) -> Void) {
        perform { context in
            do {
                let managedCache = try ProgramsCache.newUniqueInstance(in: context)
                managedCache.date = date
                managedCache.programs = ManagedProgram.tvPrograms(from: programs, in: context)
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func retrievePrograms(completion: @escaping (Result<CachedPrograms, Error>) -> Void) {
        perform { context in
            do {
                if let cache = try ProgramsCache.find(in: context) {
                    completion(.success(.found(date: cache.date!, programs: cache.tvPrograms)))
                } else {
                    completion(.success(.empty))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func retrieveChannels(completion: @escaping (Result<CachedChannels, Error>) -> Void) {
        perform { context in
            do {
                if let cache = try ChannelsCache.find(in: context) {
                    completion(.success(.found(date: cache.date!, programs: cache.tvChannels)))
                } else {
                    completion(.success(.empty))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func deleteCache(completion: @escaping (Error?) -> Void) {
        perform { context in
            do {
                try ChannelsCache.deleteCache(in: context)
                try ProgramsCache.deleteCache(in: context)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.managedContext
        context.perform {
            action(context)
        }
    }
}
