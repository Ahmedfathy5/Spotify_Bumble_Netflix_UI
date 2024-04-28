//
//  SwiftUIinPracticeApp.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 14/04/2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUIinPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            
            RouterView { _ in
                ContentView()
            }
        }
    }
}



// This extension it enable to swipe gesture back.
extension UINavigationController: UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
