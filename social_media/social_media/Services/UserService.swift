//
//  UserService.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import Foundation
import Firebase
struct UserService {
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        
        //decode data
        return try snapshot.data(as: User.self)
    }
    
    //把数据库里的东西变成array
    static func fetchAllUsers() async throws -> [User] {
        //var users = [User]()
        
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let documents = snapshot.documents
        
//        for doc in documents {
//            guard let user = try? doc.data(as: User.self) else { return users }
//            users.append(user)
//        }
        
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}


extension UserService {
    
    static func follow(uid: String) async throws {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await FirebaseConstants
            .FollowingCollection
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .setData([:])
        
        async let _ = try await FirebaseConstants
            .FollowersCollection
            .document(uid)
            .collection("user-followers")
            .document(currentUid)
            .setData([:])
        
    }
    
    static func unfollow(uid: String) async throws {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await FirebaseConstants
            .FollowingCollection
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .delete()
        
        async let _ = try await FirebaseConstants
            .FollowersCollection
            .document(uid)
            .collection("user-followers")
            .document(currentUid)
            .delete()
        
    }
    
    static func checkIfUserIsFollowed(uid: String) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        
        let snapshot = try await FirebaseConstants
            .FollowingCollection
            .document(currentUid)
            .collection("user-following")
            .document(uid)
            .getDocument()
        
        return snapshot.exists
    }
}


// 统计数据
extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats {
        async let followingSnapshot = try await FirebaseConstants
            .FollowingCollection
            .document(uid)
            .collection("user-following")
            .getDocuments()
        
        let followingCount = try await followingSnapshot.count
        
        
        async let followersSnapshot = try await FirebaseConstants
            .FollowersCollection
            .document(uid)
            .collection("user-followers")
            .getDocuments()
        
        let followersCount = try await followersSnapshot.count
        
        async let postSnapshot = try await FirebaseConstants
            .PostCollection
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        let postsCount = try await postSnapshot.count
        
        return .init(followingCount: followingCount, followersCount: followersCount, postsCount: postsCount)
    }
    
}
