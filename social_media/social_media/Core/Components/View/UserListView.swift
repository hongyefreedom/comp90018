//
//  UserListView.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import SwiftUI

struct UserListView: View {
    
    @State private var searchText = ""
    @StateObject var viewModel = UserListViewModel()
    
    private let config: UserListConfig
    
    init(config: UserListConfig) {
        self.config = config
    }
    
    var body: some View {
        ScrollView {
            // 使用.searchable样式的TextField
            TextField("Search...", text: $searchText)
                .textFieldStyle(.plain)
                .padding(.horizontal)

            LazyVStack(spacing: 12) {
                ForEach(viewModel.users.filter {
                    searchText.isEmpty || $0.username.localizedCaseInsensitiveContains(searchText)
                }) { user in
                    NavigationLink(value: user) {
                        HStack {
                            CircularProfileImageView(user: user, size: .xSmall)
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .fontWeight(.semibold)
                                if let fullname = user.fullname {
                                    Text(fullname)
                                }
                            }
                            .font(.footnote)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 8)
        }
        .task { await viewModel.fetchUsers(forConfig: config)}
    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
//}
