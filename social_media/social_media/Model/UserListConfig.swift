//
//  UserListConfig.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import Foundation

enum UserListConfig: Hashable {
    case followers(uid: String)
    case following(uid: String)
    case likes(postId: String)
    case explore
    
    var navigationTitle: String {
        switch self {
        case .followers: return "Follower"
        case .following: return "Followings"
        case .likes: return "Likes"
        case .explore: return "Explore"  
        }
    }
}
