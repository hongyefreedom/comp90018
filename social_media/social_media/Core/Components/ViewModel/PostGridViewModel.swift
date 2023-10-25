//
//  PostGridViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import Foundation

class PostGridViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    
    init(user: User) {
        self.user = user
        
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws{
        var fetchedPosts = try await PostService.fetchUserPosts(uid: user.id)
        
        
        // Sort the fetchedPosts by timestamp in descending order
        fetchedPosts.sort { post1, post2 in
            post1.timestamp.dateValue() > post2.timestamp.dateValue()
        }

        self.posts = fetchedPosts
        
        
        for i in 0..<posts.count {
            posts[i].user = self.user
        }
    }
}
