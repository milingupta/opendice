//
//  SceneDelegate.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/9/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        configureNavigationBar()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }
        
    func createOneDiceNC() -> UINavigationController {
        let oneDiceVC = OneDiceVC()
        oneDiceVC.title = "Roll 1 Die"
        oneDiceVC.tabBarItem = UITabBarItem(title: "One", image: UIImage(systemName: "1.square.fill"), tag: 0)
        
        return UINavigationController(rootViewController: oneDiceVC)
    }
    
    func createTwoDiceNC() -> UINavigationController {
        let twoDiceVC = TwoDiceVC()
        twoDiceVC.title = "Roll 2 Dice"
        twoDiceVC.tabBarItem = UITabBarItem(title: "Two", image: UIImage(systemName: "2.square.fill"), tag: 1)
        
        return UINavigationController(rootViewController: twoDiceVC)
    }
    
    func createThreeDiceNC() -> UINavigationController {
        let threeDiceVC = ThreeDiceVC()
        threeDiceVC.title = "Roll 3 Dice"
        threeDiceVC.tabBarItem = UITabBarItem(title: "Three", image: UIImage(systemName: "3.square.fill"), tag: 2)
        
        return UINavigationController(rootViewController: threeDiceVC)
    }
    
    func createFourDiceNC() -> UINavigationController {
        let fourDiceVC = FourDiceVC()
        fourDiceVC.title = "Roll 4 Dice"
        fourDiceVC.tabBarItem = UITabBarItem(title: "Four", image: UIImage(systemName: "4.square.fill"), tag: 3)
        
        return UINavigationController(rootViewController: fourDiceVC)
    }
    
    func createFiveDiceNC() -> UINavigationController {
        let fiveDiceVC = FiveDiceVC()
        fiveDiceVC.title = "Roll 5 Dice"
        fiveDiceVC.tabBarItem = UITabBarItem(title: "Five", image: UIImage(systemName: "5.square.fill"), tag: 4)
        
        return UINavigationController(rootViewController: fiveDiceVC)
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.tintColor
        tabBar.viewControllers = [createOneDiceNC(), createTwoDiceNC(), createThreeDiceNC(), createFourDiceNC(), createFiveDiceNC()]
        
        return tabBar
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor.tintColor
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
