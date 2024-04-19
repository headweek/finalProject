//
//  CoreManager.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 13.04.24.
//

import Foundation
import CoreData

class CoreManager {
    
    static let shared = CoreManager()
    var posts = [CData]()
    
    private init() {
        readData()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinalProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: Create Core Data
    func createData (item: ItemData) {
        let createData = CData(context: persistentContainer.viewContext)
        if let date = item.date {
            createData.id = "\(item.id)\(date)"
        }
        createData.image = item.imageURL
        createData.date = item.date
        createData.discription = item.description
        createData.title = item.title
        createData.link = item.link
        
        saveContext()
        readData()
    }
    
    //MARK: Read Core Data
    
    func readData () {
        let post = CData.fetchRequest()
        if let posts = try? persistentContainer.viewContext.fetch(post) {
            self.posts = posts
        }
    }
    
    func isPostSavedInCoreData() -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CData> = CData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@")
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Error fetching post: \(error)")
            return false
        }
    }
    
}
