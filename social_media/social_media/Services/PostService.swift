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

}




extension PostService {
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).setData([:])
        async let _ = try await postsCollection.document(post.id).updateData(["likes": post.likes + 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).setData([:])
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).delete()
        async let _ = try await postsCollection.document(post.id).updateData(["likes": post.likes - 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).delete()
    }
    
    static func checkIfUserLikedPost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).getDocument()
        return snapshot.exists
    }
    
    
    static func notlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-notlikes").document(uid).setData([:])
        async let _ = try await postsCollection.document(post.id).updateData(["notlikes": (post.notlikes ?? 0) + 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-notlikes").document(post.id).setData([:])
    }
    
    static func notunlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-notlikes").document(uid).delete()
        async let _ = try await postsCollection.document(post.id).updateData(["notlikes": (post.notlikes ?? 0) - 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-notlikes").document(post.id).delete()
    }
    
    static func notcheckIfUserLikedPost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-notlikes").document(post.id).getDocument()
        return snapshot.exists
    }
}






//extension PostService {
//    static func notlikePost(_ post: Post) async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        async let _ = try await postsCollection.document(post.id).collection("post-notlikes").document(uid).setData([:])
//        async let _ = try await postsCollection.document(post.id).updateData(["notlikes": post.notlikes + 1])
//        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-notlikes").document(post.id).setData([:])
//    }
//    
//    static func notunlikePost(_ post: Post) async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        async let _ = try await postsCollection.document(post.id).collection("post-notlikes").document(uid).delete()
//        async let _ = try await postsCollection.document(post.id).updateData(["notlikes": post.notlikes - 1])
//        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-notlikes").document(post.id).delete()
//    }
//    
//    static func notcheckIfUserLikedPost(_ post: Post) async throws -> Bool {
//        guard let uid = Auth.auth().currentUser?.uid else { return false }
//        
//        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-notlikes").document(post.id).getDocument()
//        return snapshot.exists
//    }
//}
