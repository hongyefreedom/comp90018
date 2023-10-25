//
//  ProfileViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}

extension ProfileViewModel {
    func follow() {
        user.isFollowed = true
        
    }
    
    func unfollow() {
        user.isFollowed = false
        
    }
    
    func checkIfUserIsFollowed() {
        
    }
}
