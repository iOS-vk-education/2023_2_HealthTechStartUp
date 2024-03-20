//
//  CoreDataManager.swift
//  Everyday
//
//  Created by Михаил on 20.03.2024.
//

import UIKit
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    let context: NSManagedObjectContext?
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to reach context")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }
    
   func getAllItems() {
       guard let context = context else {
           fatalError("Unable to reach context")
        }
       
        do {
            _ = try context.fetch(UserAuthentication.fetchRequest())
        } catch {
            // error
        }
    }
    
    func createItem(authType: String) {
        guard let context = context else {
            fatalError("Unable to reach context")
         }
        let newItem = UserAuthentication(context: context)
        newItem.authType = authType
        
        do {
            try context.save()
        } catch {
            // error
        }
    }
    
    func deleteItem(item: UserAuthentication) {
        guard let context = context else {
            fatalError("Unable to reach context")
         }
        
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            // error
        }
    }
    
    func updateItem(item: UserAuthentication, authType: String) {
        guard let context = context else {
            fatalError("Unable to reach context")
         }
        
        item.authType = authType
    
        do {
            try context.save()
        } catch {
            // error
        }
    }
    
    func deleteAllItems() {
        guard let context = context else {
            fatalError("Unable to reach context")
        }

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserAuthentication")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            fatalError("Failed to delete all items with error: \(error)")
        }
    }
}
