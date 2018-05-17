//
//  AppDelegate.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 14/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var playerView: PlayerView!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        addPlayer()
        
        return true
    }
    
    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Player
    
    @objc func playerTouched() {
        let queueVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "queue")
        self.window?.rootViewController?.present(queueVC, animated: true, completion: nil)
    }
    
    func addPlayer() {
        if let window = self.window, let playerView = Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)?.first as? PlayerView {
            playerView.addTouchTarget(self, action: #selector(playerTouched), for: .touchUpInside)
            
            playerView.translatesAutoresizingMaskIntoConstraints = false
            
            window.addSubview(playerView)
            
            let margins = window.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                playerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                playerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                playerView.heightAnchor.constraint(equalToConstant: 80),
                playerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
                ])
            
            self.playerView = playerView
            
        }
    }

}

