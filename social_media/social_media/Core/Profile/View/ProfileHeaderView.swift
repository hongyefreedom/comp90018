//
//  ProfileHeaderView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User
    @State private var showEditProfile = false
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8){
                    
                    UserStatView(value: 3, title: "Posts")
                    
                    UserStatView(value: 7, title: "Followers")
                    
                    UserStatView(value: 1, title: "Followings")
                    
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
                    print("Follow user..")
                }
                
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundColor(user.isCurrentUser ? .black: .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1))
            }
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView(user: User.MOCK_USERS[0])
//    }
//}
