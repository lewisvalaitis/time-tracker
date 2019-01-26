//
//  TimerViewController.swift
//  TimeTracker
//
//  Created by Lewis Valaitis on 19/01/2019.
//  Copyright © 2019 Lewis Valaitis. All rights reserved.
//

import UIKit

internal final class TimerViewController: UIViewController {
    @IBOutlet private var timerLabel: UILabel!
    private var timer: Timer?
    private var state = State.unnamed { didSet { update(for: state) } }
    private var isPaused = false
    @IBOutlet private var addNameButton: UIButton!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var editNameButton: UIButton!
    
}
internal extension TimerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var secondsElapsed: TimeInterval = 0.0
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        timerLabel.text = formatter.string(from: secondsElapsed)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [timerLabel] _ in
            secondsElapsed += 1.0
            timerLabel?.text = formatter.string(from: secondsElapsed)
        }
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
        resignFirstResponder()
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
            
        } else {
            button.setTitle("Pause", for: .normal)
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
