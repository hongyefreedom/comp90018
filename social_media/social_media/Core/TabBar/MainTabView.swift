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
                    VStack {
                        Image(systemName: "light.beacon.max")
                        Text("Community")
                    }
                }.tag(0)
            
            DetectView()
                .onAppear {
                    selectedIndex = 2
                }
                .tabItem {
                    VStack {
                        Image(systemName: "dot.circle.viewfinder")
                        Text("Meetal")
                    }
                }.tag(2)
            
            CurrentUserProfileView(user: user)
                .onAppear {
                    selectedIndex = 3
                }
                .tabItem {
                    VStack {
                        Image(systemName: "face.smiling")
                        Text("Me")
                    }
                }.tag(3)
        }
        .accentColor(.black)
        .background(Color.cream)
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView(user: User.MOCK_USERS[0])
//    }
//}
