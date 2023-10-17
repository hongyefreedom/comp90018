//
//  PostService.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import Foundation
import Firebase

struct PostService {
    
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await postsCollection.getDocuments()
//        self.posts = try snapshot.documents.compactMap({ document in
//            let post = try document.data(as: Post.self)
//            return post
//        })
        
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0..<posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
    
    
//    static func updateLikes(for postID: String, isLiked: Bool, completion: @escaping (Result<Int, Error>) -> Void) {
//        var likesIncrement: Int64 = 0
//        if isLiked {
//            likesIncrement = 1
//        } else {
//            likesIncrement = -1
//        }
//        
//        let postRef = postsCollection.document(postID)
//        postRef.updateData(["likes": FieldValue.increment(likesIncrement)]) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                postRef.getDocument { document, error in
//                    if let document = document, document.exists, let post = try? document.data(as: Post.self) {
//                        completion(.success(post.likes))
//                    } else {
//                        completion(.failure(NSError(domain: "Post not found", code: 404, userInfo: nil)))
//                    }
//                }
//            }
//        }
//    }

}
