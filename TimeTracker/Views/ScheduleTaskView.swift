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
    
    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var inputTime: UITextField!
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge ], completionHandler: {didAllow, error in})
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(ScheduleTaskController.dateChanged(datePicker:)), for: .valueChanged)
        inputDate.inputView = datePicker
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.addTarget(self, action: #selector(ScheduleTaskController.timeChanged(timePicker:)), for: .valueChanged)
        inputTime.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ScheduleTaskController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
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


