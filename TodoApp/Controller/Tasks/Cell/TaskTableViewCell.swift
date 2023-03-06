//
//  TaskTableViewCell.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 27.02.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var priorityView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = .clear
        self.priorityView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(task: TaskViewModel) {
        self.descriptionLabel.text = task.description
        self.titleLabel.text = task.title
        self.categoryLabel.text = task.category
        self.priorityView.backgroundColor = task.color
        self.dateLabel.text = task.date
    }
}
