//
//  ProfileViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 05.03.2023.
//

import UIKit
import Combine

class ProfileViewController: BaseViewController {
    
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    
    var coordintator: ((MainCoordinator.Destination) -> Void)?
    
    private let viewModel = ProfileViewModel()
    private var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSiblings()
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonPressed() {
        coordintator?(.logout)
    }
}

// MARK: - Combine
extension ProfileViewController {
    
    private func setupSiblings() {
        
        viewModel.$email
            .sink { [weak self] email in
                self?.emailLabel.text = email
            }
            .store(in: &cancellableSet)
        
        viewModel.$name
            .sink { [weak self] name in
                self?.nameLabel.text = name
            }
            .store(in: &cancellableSet)
        
        viewModel.update()
    }
}

extension ProfileViewController: Storyboarded {
    static var storyboardName: String {"Profile"}
}
