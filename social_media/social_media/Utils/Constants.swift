//
//  Constants.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import Firebase

struct FirebaseConstants {
    
    static let Root = Firestore.firestore()
    
    static let PostCollection = Firestore.firestore().collection("posts")
    
    static let FollowingCollection = Firestore.firestore().collection("following")
    static let FollowersCollection = Firestore.firestore().collection("followers")
}
