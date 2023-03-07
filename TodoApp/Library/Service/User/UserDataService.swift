//
//  UserDataService.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 07.03.2023.
//

import Foundation
import CoreData

protocol UserDataServiceProtocol {
    func getUser() -> User?
    func setUser(_ user: User)
    func removeUser()
}

class UserDataService: UserDataServiceProtocol {
    
    private let coreData = CoreDataService.shared
    
    func getUser() -> User? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        if let user = try? self.coreData.contenxt.fetch(request).first {
            return user.convertToTask()
        } else {
            return nil
        }
    }
    
    func setUser(_ user: User) {
        coreData.contenxt.perform {
            if let existedUser = self.findUserById(user.id) {
                existedUser.email = user.email
            } else {
                _ = UserEntity(user: user, context: self.coreData.contenxt)
            }
            
            try? self.coreData.contenxt.save()
        }
    }
    
    func removeUser() {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        if let users = try? self.coreData.contenxt.fetch(request) {
            coreData.contenxt.perform {
                users.forEach({self.coreData.contenxt.delete($0)})
            }
        }
    }
    
    private func findUserById(_ id: String) -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        return try? coreData.contenxt.fetch(request).first
    }
}
