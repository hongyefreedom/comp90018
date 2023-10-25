//
//  User.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation
import Firebase


struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isFollowed: Bool? = false
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "hongye", profileImageUrl: nil, fullname: "hongye an", bio: "a pop star", email: "hongyea@student.unimelb.edu.au"),
        .init(id: NSUUID().uuidString, username: "yixin", profileImageUrl: nil, fullname: "yixin cai", bio: "cool", email: "yixinc@student.unimelb.edu.au"),
        .init(id: NSUUID().uuidString, username: "weiyue", profileImageUrl: nil, fullname: nil, bio: "nice", email: "weiyuez@student.unimelb.edu.au")
    ]
}
