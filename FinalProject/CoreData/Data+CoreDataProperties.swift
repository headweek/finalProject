//
//  Data+CoreDataProperties.swift
//  FinalProject
//
//  Created by Salman Abdullayev on 13.04.24.
//
//

import Foundation
import CoreData

@objc(Data)
public class Data: NSManagedObject {

}

extension Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Data> {
        return NSFetchRequest<Data>(entityName: "Data")
    }

    @NSManaged public var discription: String?
    @NSManaged public var image: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var link: String?

}

extension Data : Identifiable {
    
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
        try? managedObjectContext?.save()
    }
    
}
