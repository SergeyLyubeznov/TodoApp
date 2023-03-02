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
    @IBOutlet private var categoryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(task: TaskViewModel) {
        self.descriptionLabel.text = task.description
        self.categoryLabel.text = task.id
        self.categoryView.backgroundColor = task.color
    }
}
