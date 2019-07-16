//
//  Router.swift
//  SwiftabonCoreData
//
//  Created by Uladzislau Kleshchanka on 6/3/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import UIKit

typealias Completion = () -> Void

struct Router {

    static let shared = Router()

    private init() {}

    enum Route {
        case main
        case addRecord
    }

    func route(to route: Route)  {
        logicFor(route: route)()
    }

    func logicFor(route: Route) -> () -> Void {
        switch route {
        case .main:
            return toMain
        case .addRecord:
            return toAddRecord
        }
    }
}

// Route Logic

fileprivate extension Router {
    func toMain() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        AppDelegate.shared.window = window
        let vc = Assembler.FeedViewController!
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }

    func toAddRecord() {
        let vc = Assembler.addRecordViewController!
        vc.modalPresentationStyle = .fullScreen
        let navController = UINavigationController(rootViewController: vc)
        AppDelegate.shared.window?.rootViewController?.present(navController, animated: true, completion: nil)
    }
}
