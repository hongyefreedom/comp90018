//
//  social_mediaApp.swift
//  social_media
//
//  Created by 安泓晔 on 29/8/2023.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct social_mediaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(feedViewModel) // 注入 FeedViewModel 到视图中
        }
    }
}
