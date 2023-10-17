//
//  SearchView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
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
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
