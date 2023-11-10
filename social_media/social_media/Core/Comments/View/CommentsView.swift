//
//  CommentsView.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import SwiftUI

struct CommentsView: View {
    @State private var commentText = ""
    @StateObject var viewModel: CommentsViewModel
    
    
    @State private var canPost = false

    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: CommentsViewModel(post: post))
    }
    
    var body: some View {
        VStack {
            
            Text("Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top, 24)
            
            Divider()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }.padding(.top)
            
            Divider()
            
            HStack(spacing: 12) {
                //CircularProfileImageView(user: User.MOCK_USERS[0], size: .xSmall)

                ZStack(alignment: .trailing) {
                    TextField("Add a comment...", text: $commentText, axis: .vertical)
                        .padding(12)
                        .padding(.trailing, 40)
                        .overlay {
                            Capsule()
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        }

                    Button {
                        Task {
                            
                            canPost = true
                            
                            try await viewModel.uploadComment(commentText: commentText)
                            commentText = ""
                            
                            
                            canPost = false
                        }
                        
                        
                    } label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .padding(.horizontal)
                    .disabled(canPost)
                }

            }
            .padding()
            

        }
        .background(Color.cream)
    }
}

//struct CommentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsView()
//    }
//}
