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
    @IBOutlet private var tableView: UITableView!
    /// All tasks.
    private var tasks: [Task] = []
}
// MARK: View Lifecycle
extension TaskListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        tasks = Array(realm.objects(Task.self))
        print(tasks)
        tableView.reloadData()
    }
}
// MARK: UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.configure(with: task)
        return cell
    }
}
// MARK: Task Cell
final class TaskCell: UITableViewCell {
    // MARK Constants
    static let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    // MARK: Properties
    /// Displays the name of the task.
    @IBOutlet private var nameLabel: UILabel!
    /// Displays the date on which the task occured.
    @IBOutlet private var dateLabel: UILabel!
    /// Displays the time at which the task occured.
    @IBOutlet private var timeLabel: UILabel!
}
extension TaskCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        dateLabel.text = nil
        timeLabel.text = nil
    }
}
extension TaskCell {
    func configure(with task: Task) {
        nameLabel.text = task.name
        dateLabel.text = TaskCell.dateFormatter.string(from: task.startTime)
        let start = TaskCell.timeFormatter.string(from: task.startTime)
        let end = TaskCell.timeFormatter.string(from: task.endTime)
        timeLabel.text = start + " - " + end
    }
}
