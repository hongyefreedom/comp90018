//
//  ProfileTabBar.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/10.
//

import SwiftUI

struct ProfileTabBar: View {
    
    var user: User
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            // Tabs as buttons
            HStack {
                Spacer()
                Button {
                    selectedTab = 0
                    
                } label: {
                    VStack {
                        Image(systemName: "square.and.arrow.up.on.square").fixedSize()
                        Text("published")
                    }
                }
                
                .foregroundColor(selectedTab == 0 ? .blue : .gray)
                
                Spacer()

                Button {
                    selectedTab = 1
                }label: {
                    VStack {
                        Image(systemName: "list.bullet.indent").fixedSize()
                        Text("record")
                    }
                }
                .foregroundColor(selectedTab == 1 ? .blue : .gray)
                
                Spacer()
            }
            .padding()

            if selectedTab == 0 {
                GridView(user: user)
                
            } else if selectedTab == 1 {
                
                DetectRecordsView(user: user)
                
            }
        }
        .background(Color.cream)
    }
}

struct ProfileTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabBar(user: User.MOCK_USERS[0])
    }
}
