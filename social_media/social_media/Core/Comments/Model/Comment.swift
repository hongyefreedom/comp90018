//
//  Comment.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Codable {
    @DocumentID var commentId: String?
    let postOwnerUid: String
    let commentText: String
    let postId: String
    let timestamp: Timestamp
    let commentOwnerUid: String
    
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
    
    var user: User?
}

