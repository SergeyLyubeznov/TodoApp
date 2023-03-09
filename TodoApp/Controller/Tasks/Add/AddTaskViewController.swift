//
//  AddTaskViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 09.03.2023.
//

import UIKit

class AddTaskViewController: BaseViewController, Storyboarded {
    
    private var viewModel: TasksViewModel?
    
    func setViewModel(_ viewModel: TasksViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed() {
        viewModel?.addTask()
    }
}
