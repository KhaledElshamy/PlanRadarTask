//
//  DataManager.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import Foundation
import CoreData

open class DataController {
    
    public static let modelName = "PlanRadarTask"

    public static let model: NSManagedObjectModel = {
      let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
      return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    public init() {
    }

    public lazy var mainContext: NSManagedObjectContext = {
      return storeContainer.viewContext
    }()

    public lazy var storeContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: DataController.modelName)
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
          self.autoSaveViewContext()
      }
      return container
    }()

    public func newDerivedContext() -> NSManagedObjectContext {
      let context = storeContainer.newBackgroundContext()
      return context
    }

    public func saveContext() {
      saveContext(mainContext)
    }

    public func saveContext(_ context: NSManagedObjectContext) {
      if context != mainContext {
        saveDerivedContext(context)
        return
      }

      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
    }

    public func saveDerivedContext(_ context: NSManagedObjectContext) {
      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }

        self.saveContext(self.mainContext)
      }
    }
}

// MARK: - Autosaving

extension DataController {
    func autoSaveViewContext(interval:TimeInterval = 3) {
        print("autosaving")
        
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        
        if mainContext.hasChanges {
            try? mainContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}
