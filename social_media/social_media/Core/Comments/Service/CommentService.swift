//
//  CommentService.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import Foundation

import FirebaseFirestoreSwift
import Firebase

struct CommentService {
    
    static func uploadComment(_ comment: Comment, postId: String) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return}
        
        try await Firestore
            .firestore()
            .collection("posts")
            .document(postId)
            .collection("post-comments")
            .addDocument(data: commentData)
    }
    
}
