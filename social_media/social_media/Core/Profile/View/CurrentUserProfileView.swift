//
//  CurrentUserProfileView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let user: User
    
//    var posts: [Post] {
//        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username})
//    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // header
                // spacing = .padding(.botto)
                ProfileHeaderView(user: user)
                
                
                ProfileTabBar(user: user)
                
                // grid
                // 行间距
                //GridView(user: user)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signout()
                    } label: {
                        Image(systemName: "arrow.right.circle")
                            .foregroundColor(.black)
                            .imageScale(.large)
                    }

                }
            }
            .background(Color.cream)
        }
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: User.MOCK_USERS[0])
    }
}
