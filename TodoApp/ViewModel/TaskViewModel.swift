//
//  TaskViewModel.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 28.02.2023.
//

import Foundation
import UIKit

struct TaskViewModel {
    let id: String
    let title: String
    let description: String
    let color: UIColor
    let category = "Base"
    let date = Date().formatted(date: .abbreviated, time: .shortened)
}
