//
//  AppDelegate.swift
//  TimeTracker
//
//  Created by Lewis Valaitis on 18/12/2018.
//  Copyright © 2018 Lewis Valaitis. All rights reserved.
//

import RealmSwift
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //  when migrating the database we simply delete the old data
        //  this is for development purposes
        //  in production I would create a migration policy such that I persist user data
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
        return true
    }
}
