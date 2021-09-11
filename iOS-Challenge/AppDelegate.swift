//
//  AppDelegate.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyboard = UIStoryboard(name: "RedditPost", bundle: nil)
            let rootViewController = storyboard.instantiateInitialViewController() as! RedditPostViewController
            self.window?.rootViewController = rootViewController

        } else {
            let storyboard = UIStoryboard(name: "RedditPostIPAD", bundle: nil)
            let rootViewController = storyboard.instantiateInitialViewController() as! RedditPostViewController
            self.window?.rootViewController = rootViewController

        }
        return true
    }
}

