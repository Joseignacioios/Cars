//
//  AppDelegate.swift
//  Cars
//
//  Created by Joce on 14.09.2021.
//

import Swinject
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let assembler = Assembler([
        CarSearchAssembly(),
        CarsListAssembly()
    ])
    

    private func startApp() {
        applyStyle()
        window = UIWindow(frame: UIScreen.main.bounds)
        let listBuilder = assembler.resolver.resolve(CarsListBuilderProtocol.self)!
        window?.rootViewController = UINavigationController(rootViewController: listBuilder.build())
        window?.makeKeyAndVisible()
    }

    private func applyStyle() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = .design(.constant(style: .brand))
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.design(.text(style: .primaryReversed))]
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applyStyle()
        startApp()
        return true
    }
}
