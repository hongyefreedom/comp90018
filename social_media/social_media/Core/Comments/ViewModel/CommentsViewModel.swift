//
//  CommentsViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

@MainActor
class CommentsViewModel: ObservableObject {
    @Published var comments = [Comment]()
    
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func uploadComment(commentText: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let comment = Comment(
            postOwnerUid: post.ownerUid,
            commentText: commentText,
            postId: post.id,
            timestamp: Timestamp(),
            commentOwnerUid: uid
        )
        
        try await CommentService.uploadComment(comment, postId: post.id)

    }
}

