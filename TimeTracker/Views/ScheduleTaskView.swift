//
//  ScheduleTaskView.swift
//  TimeTracker
//
//  Created by Lewis Valaitis on 05/03/2019.
//  Copyright © 2019 Lewis Valaitis. All rights reserved.
//

import UIKit
import UserNotifications

internal final class ScheduleTaskController: UIViewController {
    
    @IBOutlet weak var taskLabel: UITextField!
    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var inputTime: UITextField!
    private let datePicker = UIDatePicker()
    private let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge ], completionHandler: {didAllow, error in})
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(ScheduleTaskController.dateChanged(datePicker:)), for: .valueChanged)
        inputDate.inputView = datePicker
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(ScheduleTaskController.timeChanged(timePicker:)), for: .valueChanged)
        inputTime.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ScheduleTaskController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func addTaskNotification(_ sender: Any) {
        let datePickerComponents = Calendar.current.dateComponents(in: .current, from: datePicker.date)
        let timePickerComponents = Calendar.current.dateComponents(in: .current, from: timePicker.date)
        let taskDateComponents = DateComponents(calendar: .current, timeZone: .current,
                                                year: datePickerComponents.year, month: datePickerComponents.month, day: datePickerComponents.day,
                                                hour: timePickerComponents.hour, minute: timePickerComponents.minute, weekday: datePickerComponents.weekday)
        
        let taskNotificaton = UNMutableNotificationContent()
        if let taskName = taskLabel.text{
             taskNotificaton.body = "Time to start \(taskName)"
        }
        taskNotificaton.title = "Reminder"
        taskNotificaton.badge = 1
        let trigger = UNCalendarNotificationTrigger(dateMatching: taskDateComponents, repeats: false)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
            view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        inputDate.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        inputTime.text = timeFormatter.string(from: timePicker.date)
    }
}


