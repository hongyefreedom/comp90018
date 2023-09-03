//
//  User.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation


struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "hongye", profileImageUrl: "head", fullname: "hongye an", bio: "a pop star", email: "hongyea@student.unimelb.edu.au"),
        .init(id: NSUUID().uuidString, username: "yixin", profileImageUrl: "head1", fullname: "yixin cai", bio: "cool", email: "yixinc@student.unimelb.edu.au"),
        .init(id: NSUUID().uuidString, username: "weiyue", profileImageUrl: "head2", fullname: nil, bio: "nice", email: "weiyuez@student.unimelb.edu.au")
    ]
}
