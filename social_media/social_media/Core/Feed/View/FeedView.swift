//
//  FeedView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct FeedView: View {
    
    
    @EnvironmentObject var viewModel: FeedViewModel
    // @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: 40) {
                    ForEach(viewModel.posts.reversed()) { post in
                        FeedCell(post: post)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("head")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
            .background(Color.cream)
            
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Image(systemName: "paperplane")
//                        .imageScale(.large)
//                }
//            }
        }
    }
}


//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
