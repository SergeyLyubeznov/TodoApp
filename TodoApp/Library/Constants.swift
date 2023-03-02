//
//  Constants.swift
//  Test
//
//  Created by Serhii Liubeznov on 18.11.2022.
//

import Foundation

struct Constants {
    private init() {}
    
    // MARK: - Api
    
    struct Api {
        static let Host = "http://127.0.0.1:8080"
        static let Tasks = "tasks"
        static let SignUp = "registration"
        static let Login = "login"
    }
    
    // MARK: - Colors
    
    struct Colors {
        static let TaskHightPriority = "C92E27"
        static let TaskMidPriority = "515283"
        static let TaskLowPriority = "51877F"
    }
    
    // MARK: - Storyboard
    
    struct Storyboard {
        static let Login = "Login"
        static let Main = "Main"
    }
}
