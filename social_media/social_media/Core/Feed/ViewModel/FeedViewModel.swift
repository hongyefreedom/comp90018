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
        self.posts = try await PostService.fetchFeedPosts()
    }
}
