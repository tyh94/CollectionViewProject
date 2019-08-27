//
//  AppDelegate.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 26/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().barStyle = .black

        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController()
        let presenter = MainPresenter(viewInput: vc,
                                      imageDownloader: ImageDownloaderFile())
        vc.viewOutput = presenter
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.barStyle = .black
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

