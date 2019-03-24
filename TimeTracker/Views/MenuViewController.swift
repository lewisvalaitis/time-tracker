//
//  ViewController.swift
//  TimeTracker
//
//  Created by Lewis Valaitis on 18/12/2018.
//  Copyright © 2018 Lewis Valaitis. All rights reserved.
//

import UIKit
import RealmSwift

/**
 The home screen from which the user can start a task, look at previous tasks, and schedule a task.
 */
internal final class MenuViewController: UIViewController {
}
/**
 This is create to correct an issue with UIImageView as stated in the follow radar:
 http://openradar.appspot.com/18448072
 */
extension UIImageView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }
}
