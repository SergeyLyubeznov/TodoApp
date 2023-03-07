//
//  UserEntity.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 07.03.2023.
//

import UIKit
import CoreData

class UserEntity: NSManagedObject {
    
    @NSManaged public var id: String
    @NSManaged public var email: String
    @NSManaged public var lastName: String
    @NSManaged public var firstName: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }
    
    convenience init(user: User, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = user.id
        self.email = user.email
        self.firstName = user.firstName
        self.lastName = user.lastName
    }
    
    func convertToTask() -> User {
        return User(id: id, email: email, firstName: firstName, lastName: lastName)
    }
}

