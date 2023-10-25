//
//  Post.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation
import Firebase
import CoreLocation

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
    var location: CLLocation?
    
    var didLike: Bool? = false

    enum CodingKeys: String, CodingKey {
        case id
        case ownerUid
        case caption
        case likes
        case imageUrl
        case timestamp
        case user
        case location
        case locationLatitude // 添加地理位置纬度键
        case locationLongitude // 添加地理位置经度键
    }

    init(id: String, ownerUid: String, caption: String, likes: Int, imageUrl: String, timestamp: Timestamp, location: CLLocation?, user: User? = nil) {
        self.id = id
        self.ownerUid = ownerUid
        self.caption = caption
        self.likes = likes
        self.imageUrl = imageUrl
        self.timestamp = timestamp
        self.location = location
        self.user = user
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        ownerUid = try container.decode(String.self, forKey: .ownerUid)
        caption = try container.decode(String.self, forKey: .caption)
        likes = try container.decode(Int.self, forKey: .likes)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        timestamp = try container.decode(Timestamp.self, forKey: .timestamp)
        user = try container.decodeIfPresent(User.self, forKey: .user)

        // Handle decoding of location
        if let latitude = try container.decodeIfPresent(Double.self, forKey: .locationLatitude),
           let longitude = try container.decodeIfPresent(Double.self, forKey: .locationLongitude) {
            location = CLLocation(latitude: latitude, longitude: longitude)
        } else {
            location = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(ownerUid, forKey: .ownerUid)
        try container.encode(caption, forKey: .caption)
        try container.encode(likes, forKey: .likes)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(user, forKey: .user)

        // Handle encoding of location
        if let location = location {
            try container.encode(location.coordinate.latitude, forKey: .locationLatitude)
            try container.encode(location.coordinate.longitude, forKey: .locationLongitude)
        }
    }
}



//extension Post {
//    static var MOCK_POSTS: [Post] = [
//        .init(
//            id: NSUUID().uuidString,
//            ownerUid: NSUUID().uuidString,
//            caption: "i am happy",
//            likes: 125,
//            imageUrl: "head",
//            timestamp: Timestamp(),
//            user: User.MOCK_USERS[0]
//        ),
//
//        .init(
//            id: NSUUID().uuidString,
//            ownerUid: NSUUID().uuidString,
//            caption: "i am sad",
//            likes: 75,
//            imageUrl: "head2",
//            timestamp: Timestamp(),
//            user: User.MOCK_USERS[2]
//        ),
//
//        .init(
//            id: NSUUID().uuidString,
//            ownerUid: NSUUID().uuidString,
//            caption: "i am angry",
//            likes: 15,
//            imageUrl: "head1",
//            timestamp: Timestamp(),
//            user: User.MOCK_USERS[1]
//        ),
//
//        .init(
//            id: NSUUID().uuidString,
//            ownerUid: NSUUID().uuidString,
//            caption: "i am happy?",
//            likes: 1285,
//            imageUrl: "head1",
//            timestamp: Timestamp(),
//            user: User.MOCK_USERS[0]
//        )
//    ]
//}
