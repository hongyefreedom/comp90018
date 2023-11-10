//
//  MainTabView.swift
//  social_media
//
//  Created by 安泓晔 on 29/8/2023.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    @State private var selectedIndex = 2
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            
            FeedView()
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "light.beacon.max")
                }.tag(0)
            
            DetectView()
                .onAppear {
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "dot.circle.viewfinder")
                }.tag(2)
            
            CurrentUserProfileView(user: user)
                .onAppear {
                    selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "face.smiling")
                }.tag(3)
        }
        .accentColor(.black)
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView(user: User.MOCK_USERS[0])
//    }
//}
