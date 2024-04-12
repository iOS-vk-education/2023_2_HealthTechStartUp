//
//  CoreDataManager.swift
//  Everyday
//
//  Created by Михаил on 20.03.2024.
//

import UIKit
import CoreData

protocol CoreDataServiceDescription {
    func getAllItems() -> [String]?
    func createItem(authType: String)
    func deleteItem(item: UserAuthentication)
    func updateItem(item: UserAuthentication, authType: String)
    func deleteAuthType(authType: String)
    func deleteAllItems()
    func isItemExists(for key: String) -> Bool
}

class CoreDataService: CoreDataServiceDescription {
    static let shared = CoreDataService()
    let context: NSManagedObjectContext?
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to reach context")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }
        
    func getAllItems() -> [String]? {
        guard let context = context else {
            fatalError("Unable to reach context")
        }
        
        do {
            let items = try context.fetch(UserAuthentication.fetchRequest()) as? [UserAuthentication]
            let authTypes = items?.compactMap { $0.authType }
            return authTypes
        } catch {
            print("Error fetching items: \(error)")
            return nil
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
    
    func deleteAuthType(authType: String) {
        guard let context = CoreDataService.shared.context else {
                    print("Context is unavailable")
                    return
                }
                
                let fetchRequest: NSFetchRequest<UserAuthentication> = UserAuthentication.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "authType == %@", authType)
                
                do {
                    let items = try context.fetch(fetchRequest)
                    if let itemToDelete = items.first {
                        CoreDataService.shared.deleteItem(item: itemToDelete)
                        print("Item \(authType) deleted successfully")
                    } else {
                        print("No item found with authType \(authType)")
                    }
                } catch let error as NSError {
                    print("Could not fetch or delete \(authType): \(error), \(error.userInfo)")
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
    
    func isItemExists(for key: String) -> Bool {
        guard let context = context else {
            fatalError("Unable to reach context")
        }
        
        let fetchRequest: NSFetchRequest<UserAuthentication> = UserAuthentication.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "authType == %@", key)
        
        do {
            let items = try context.fetch(fetchRequest)
            return !items.isEmpty
        } catch {
            return false
        }
    }
}
