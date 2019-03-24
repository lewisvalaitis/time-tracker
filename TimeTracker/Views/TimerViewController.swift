//
//  TimerViewController.swift
//  TimeTracker
//
//  Created by Lewis Valaitis on 19/01/2019.
//  Copyright © 2019 Lewis Valaitis. All rights reserved.
//

import UIKit
import RealmSwift

/**
 Automatically starts a task. Allows the user to name, pause, and stop the task.
 */
internal final class TimerViewController: UIViewController {
    private var task: Task!
    private var timer: Timer?
    private var secondsElapsed: Int = 0
    private var state = State.unnamed { didSet { update(for: state) } }
    private var isPaused = false
    
    @IBOutlet private var timerLabel: UILabel!
    @IBOutlet private var addNameButton: UIButton!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var editNameButton: UIButton!
    
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    deinit {
        timer?.invalidate()
    }
}
internal extension TimerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        task = Task(name: "Unnamed task")
        startTimer()
        state = .unnamed
    }
}
extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let name = textField.text, !name.isEmpty {
            state = .named(name)
        } else {
            state = .unnamed
        }
        textField.resignFirstResponder()
        return false
    }
}
private extension TimerViewController {
    @IBAction func addName() {
        state = .editingName(nil)
    }
    
    @IBAction func editName() {
        switch state {
        case .unnamed:
            state = .editingName(nil)
        case .named(let name):
            state = .editingName(name)
        case .editingName:
            fatalError("Bad state.")
        }
    }
    
    @IBAction func pauseTimer(_ button: UIButton) {
        isPaused.toggle()
        if isPaused {
            button.setTitle("Resume", for: .normal)
            timer?.invalidate()
        } else {
            button.setTitle("Pause", for: .normal)
            startTimer()
        }
        
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        timer?.invalidate()
        if case .editingName = state {
            _ = nameTextField.delegate?.textFieldShouldReturn?(nameTextField)
        }
        var savedTaskName = ""
        let realm = try! Realm()
        try! realm.write {
            if let taskName = nameLabel.text, !taskName.isEmpty {
                task.name = taskName
            }
            task.duration = secondsElapsed
            realm.add(task)
            savedTaskName = task.name
        }
        
        //  allows me, as the developer, to open the database while I'm working
        print(Realm.Configuration.defaultConfiguration.fileURL ?? nil!)
        
        let alert = UIAlertController(title: "'\(savedTaskName)' Created", message: "Your task has been created.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Thanks!", style: .default) { [unowned self] _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}


private extension TimerViewController {
    func startTimer() {
        timerLabel.text = formatter.string(from: Double(secondsElapsed))
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] _ in
            self.secondsElapsed += 1
            self.timerLabel.text = self.formatter.string(from: Double(self.secondsElapsed))
        }
    }
}

private extension TimerViewController {
    enum State {
        case named(String)
        case unnamed
        case editingName(String?)
    }
    func update(for state: State) {
        switch state {
        case .named(let name):
            nameLabel.text = name
            nameLabel.isHidden = false
            editNameButton.isHidden = false
            addNameButton.isHidden = true
            nameTextField.isHidden = true
        case .editingName(let startName):
            nameTextField.text = startName
            nameLabel.isHidden = true
            editNameButton.isHidden = true
            addNameButton.isHidden = true
            nameTextField.isHidden = false
        case .unnamed:
            nameLabel.isHidden = true
            editNameButton.isHidden = true
            addNameButton.isHidden = false
            nameTextField.isHidden = true
        }
    }
}
