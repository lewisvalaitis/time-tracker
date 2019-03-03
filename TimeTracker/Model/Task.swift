//
//  Task.swift
//  TimeTracker
//
//  Created by Lewis Valaitis on 26/02/2019.
//  Copyright © 2019 Lewis Valaitis. All rights reserved.
//

import Foundation
import RealmSwift

/**
 A task is representative of a user's tracked activity.
 */
final class Task: Object {
    // MARK: Properties
    /// Name of the task.
    @objc dynamic var name = ""
    /// The time at which the task began.
    @objc dynamic var startTime = Date()
    /// The number of seconds the task lasted.
    @objc dynamic var duration: Int = 0
    /// The times at which the user paused the task.
    let pauseTimes = List<Date>()
}
extension Task {
    // MARK: Initializer
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
