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

//    private var currentUser: User? {
//    }
    
    //初始化 stateobject
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
//                    ForEach(0...15, id: \.self) { comment in
//                        CommentCell()
//                    }
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
                        Task {try await viewModel.uploadComment(commentText: commentText)
                            commentText = ""
                        }
                    } label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .padding(.horizontal)
                }

            }
            .padding()
            

        }
    }
    
//    func uploadComment() {
//        Task {
//            try await viewModel.uploadComment(commentText: commentText)
//            commentText = ""
//        }
//    }
}

//struct CommentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsView()
//    }
//}
