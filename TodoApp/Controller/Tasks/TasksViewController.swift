//
//  TasksViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 27.02.2023.
//

import UIKit
import Combine

class TasksViewController: BaseViewController, Storyboarded {
    
    @IBOutlet private var tableView: UITableView!
    
    var coordintator: ((MainCoordinator.Destination) -> Void)?
    
    lazy private var activityView = {ActivityIndicatorView.instantiate()}()
    
    private let service: TasksService = TasksNetworkService()
    private var cancellableSet: Set<AnyCancellable> = []
    private var viewModel: TasksViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupActivityIndicator()
        setupSiblings()
    }
    
    func setViewModel(_ viewModel: TasksViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupActivityIndicator() {
        self.view.addSubview(self.activityView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityView.center = self.view.center
    }
    
    private func setupUI() {
        self.title = "Tasks"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(TaskTableViewCell.identifier)
    }
    
    // MARK: - Combine
    private func setupSiblings() {
        
        viewModel?.$success
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellableSet)
        
        viewModel?.$activityIndicator
            .sink { [weak self] state in
                if state {
                    self?.activityView.startAnimating()
                } else {
                    self?.activityView.stopAnimating()
                }
            }
            .store(in: &cancellableSet)
        
        viewModel?.update()
        viewModel?.getTasks()
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed() {
        if let viewModel = viewModel {
            coordintator?(.addTask(viewModel))
        }
    }
}

// MARK: - UITableViewDataSource
extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.tasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath)
        if let cell = cell as? TaskTableViewCell, let task = viewModel?.tasks[indexPath.row] {
            cell.configure(task: task)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TasksViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (_, _, _) in
            if let item = self.viewModel?.tasks[indexPath.row] {
                self.viewModel?.deleteTaskById(item.id)
            }
        }
        
        deleteAction.image = .init(named: "trash_icon")
        deleteAction.backgroundColor = .init(hex: "FBFBFB")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
