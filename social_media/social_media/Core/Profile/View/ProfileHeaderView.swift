//
//  ProfileHeaderView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    // let user: User
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false
    
    private var user: User {
        return viewModel.user
    }
    
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    
    private var stats: UserStats {
        return user.stats ?? .init(followingCount: 0, followersCount: 0, postsCount: 0)
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    
    private var buttonBackgroundColor: Color {
        if isFollowed {
            return .gray
        } else {
            return Color(.systemBlue)
        }
    }
    
    init(user: User){
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8){
                    
                    UserStatView(value: stats.postsCount,
                                 title: "Posts")
                    
                    UserStatView(value: stats.followersCount, title: "Followers")
                    
                    UserStatView(value: stats.followingCount, title: "Followings")
                    
                }
            }
            .padding(.horizontal)
            //.padding(.bottom, 4)
            
            
            VStack(alignment: .leading, spacing: 4){
                
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                    //.fontWeight(.semibold)
                }
                
                //Text(user.username)
            }
            //把stack放到最左边
            .frame(maxWidth: .infinity, alignment: .leading)
            // 稍微回来一点
            .padding(.horizontal)
            //.padding(.bottom, 4)
            
            
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    handleFollowTapped()
                }
                
            } label: {
                Text(buttonTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(buttonBackgroundColor)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1))
            }
            Divider()
        }
        .onAppear{
            viewModel.fetchUserStats()
            viewModel.checkIfUserIsFollowed()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
    
    func handleFollowTapped() {
        if isFollowed {
            viewModel.unfollow()
        } else{
            viewModel.follow()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.MOCK_USERS[0])
    }
}
