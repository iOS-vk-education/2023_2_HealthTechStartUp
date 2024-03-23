//
//  UserAuthentication+CoreDataProperties.swift
//  Everyday
//
//  Created by Михаил on 20.03.2024.
//
//

import Foundation
import CoreData

extension UserAuthentication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAuthentication> {
        return NSFetchRequest<UserAuthentication>(entityName: "UserAuthentication")
    }

    @NSManaged public var authType: String?
}

extension UserAuthentication: Identifiable {
}
