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
        
        // MARK: - TabBar
        static let TabBarTintColor = "8A817C"
    }
    
    // MARK: - Storyboard
    struct Storyboard {
        static let Login = "Login"
        static let Main = "Main"
    }
    
    // MARK: - Validators
    struct Valid {
        static let PasswordLenght = 8
        static let EmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    // MARK: - TabBar
    struct TabBarTitle {
        static let Tasks = "Tasks"
        static let Profile = "Profile"
    }
    
    struct TabBarIcon {
        static let Tasks = "tab_tasks_icon"
        static let Profile = "tab_profile_icon"
    }
    
    struct TabBarSelectedIcon {
        static let Tasks = "tab_tasks_selected_icon"
        static let Profile = "tab_profile_selected_icon"
    }
}
