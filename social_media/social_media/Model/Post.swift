//
//  Post.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Date
    var user: User?
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "i am happy",
            likes: 125,
            imageUrl: "head",
            timestamp: Date(),
            user: User.MOCK_USERS[0]
        ),
        
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "i am sad",
            likes: 75,
            imageUrl: "head2",
            timestamp: Date(),
            user: User.MOCK_USERS[2]
        ),
        
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "i am angry",
            likes: 15,
            imageUrl: "head1",
            timestamp: Date(),
            user: User.MOCK_USERS[1]
        ),
        
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "i am happy?",
            likes: 1285,
            imageUrl: "head1",
            timestamp: Date(),
            user: User.MOCK_USERS[0]
        )
    ]
}
