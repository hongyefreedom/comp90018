//
//  ProfileView.swift
//  social_media
//
//  Created by 安泓晔 on 29/8/2023.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
//    var posts: [Post] {
//        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username})
//    }
    
    
    
    var body: some View {
        //NavigationStack {
            ScrollView {
                // header
                // spacing = .padding(.botto)
                ProfileHeaderView(user: user)
                
                ProfileTabBar(user: user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.cream)
        }
    //}
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0])
    }
}
