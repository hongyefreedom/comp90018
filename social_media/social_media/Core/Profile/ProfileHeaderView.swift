//
//  ProfileHeaderView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                Image(user.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
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
            }
            //把stack放到最左边
            .frame(maxWidth: .infinity, alignment: .leading)
            // 稍微回来一点
            .padding(.horizontal)
            //.padding(.bottom, 4)
            
            
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1))
            }
            Divider()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.MOCK_USERS[0])
    }
}
