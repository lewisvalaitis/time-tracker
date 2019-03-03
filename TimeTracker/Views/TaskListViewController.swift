//
//  TaskListViewController.swift
//  TimeTracker
//
//  Created by Lewis Valaitis on 03/03/2019.
//  Copyright © 2019 Lewis Valaitis. All rights reserved.
//

import RealmSwift

/**
 Lists all of the user's tasks in order of when they began.
 */
final class TaskListViewController: UIViewController {
    //  MARK: Properties
    /// Used to list the tasks in a table.
    private var tableView: UITableView!
}
// MARK: View Lifecycle
extension TaskListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
// MARK: Task Cell
final class TaskCell: UITableViewCell {
    // MARK: Properties
    /// Displays the name of the task.
    @IBOutlet private var nameLabel: UILabel!
}
