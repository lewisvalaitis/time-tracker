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
    let pauseTimes = List<Pause>()
    /// The properties to be ignored by the database.
    override static func ignoredProperties() -> [String] {
        return [
            "endTime"
        ]
    }
}
// MARK: Initializer
extension Task {
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
// MARK: Computed Properties
extension Task {
    var endTime: Date {
        let totalPauseTime = pauseTimes.reduce(0) { current, pause in current + pause.duration }
        let totalDuration = TimeInterval(duration + totalPauseTime)
        return Date(timeInterval: totalDuration, since: startTime)
    }
}

final class Pause: Object {
    @objc dynamic var start = Date()
    @objc dynamic var duration: Int = 0
}
