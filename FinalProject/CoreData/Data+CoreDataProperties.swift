//
//  Data+CoreDataProperties.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 13.04.24.
//
//

import Foundation
import CoreData

@objc(CData)
public class CData: NSManagedObject {

}

extension CData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CData> {
        return NSFetchRequest<CData>(entityName: "CData")
    }

    @NSManaged public var id: String?
    @NSManaged public var discription: String?
    @NSManaged public var image: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var link: String?

}

extension CData : Identifiable {
    
    //MARK: Update Core Data
    
    func updateData (newItem: ItemData) {
        self.date = newItem.date
        self.discription = newItem.description
        self.image = newItem.imageURL
        self.link = newItem.link
        self.title = newItem.title
        
        try? managedObjectContext?.save()
    }
    
    //MARK: Delete Core Data
    
    func deleteData () {
        managedObjectContext?.delete(self)
        let cManager = CoreManager.shared
        cManager.readData()
        try? managedObjectContext?.save()
    }
    
}
