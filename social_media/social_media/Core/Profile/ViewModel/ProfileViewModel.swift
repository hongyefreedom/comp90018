//
//  ProfileViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        //checkIfUserIsFollowed()
        //fetchUserStats()
    }
    
    func fetchUserStats(){
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        Task {
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
}
