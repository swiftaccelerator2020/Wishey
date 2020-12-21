//
//  SceneDelegate.swift
//  ฿u₫g€+
//
//  Created by Swift Accelator 2020 Group 3 on 26/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
//        if let stuff = UserDefaults.standard.string(forKey: "LaunchViewController") {
//            // Create a reference to the Storyboard file
//            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            // Create a reference to the ViewController you want to open
//            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: stuff)
////
////            let navigationController = UINavigationController.init(rootViewController: vc)
//
//            // Present the ViewController
//            DispatchQueue.global(qos: .default).async {
//
//                // Background Thread
//
//                DispatchQueue.main.async {
////                    vc.view.frame = (self.window!.frame)
//                    self.window!.addSubview(vc.view)
//                    self.window!.bringSubviewToFront(vc.view)
////                    navigationController.navigationBar.prefersLargeTitles = true
//                    self.window?.rootViewController = vc
//                    self.window?.makeKeyAndVisible()
//                    // Run UI Updates
////                     self.presentViewController(vc, animated: true, completion: nil)
//                }
//            }
//        } else {
//            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            // Create a reference to the ViewController you want to open
//            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
////
////            let navigationController = UINavigationController.init(rootViewController: vc)
//
//            // Present the ViewController
//            DispatchQueue.global(qos: .background).async {
//
//                // Background Thread
//
//                DispatchQueue.main.async {
//                    vc.view.frame = (self.window!.frame)
//                    self.window!.addSubview(vc.view)
//                    self.window!.bringSubviewToFront(vc.view)
////                    navigationController.navigationBar.prefersLargeTitles = true
//                    self.window?.rootViewController = vc
//                    self.window?.makeKeyAndVisible()
//                    // Run UI Updates
//                    // self.presentViewController(vc, animated: true, completion: nil)
//                }
//            }
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

