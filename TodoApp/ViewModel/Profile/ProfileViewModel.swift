//
//  ProfileViewModel.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 07.03.2023.
//

import UIKit

class ProfileViewModel {
    
    @Published var name = ""
    @Published var email = ""
    
    private let dataService: UserDataServiceProtocol
    
    init() {
        dataService = UserDataService()
    }
    
    func update() {
        if let user = dataService.getUser() {
            self.name = user.fullName()
            self.email = user.email
        }
    }
}
