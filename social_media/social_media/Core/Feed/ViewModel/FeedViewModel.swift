//
//  FeedViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task { try await fetchPosts()}
    }
    
    @MainActor
    func fetchPosts() async throws {
        var fetchedPosts = try await PostService.fetchFeedPosts()
        fetchedPosts.sort { $0.timestamp < $1.timestamp }
        self.posts = fetchedPosts
    }
}
