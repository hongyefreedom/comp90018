//
//  FeedCellViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import SwiftUI
import Firebase

@MainActor
class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        Task { try await checkIfUserLikedPost() }
        Task { try await notcheckIfUserLikedPost() }
    }
    
    func like() async throws {
        
        do {
            let postCopy = post
            post.didLike = true
            post.likes += 1
            try await PostService.likePost(postCopy)
        } catch {
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unlike() async throws {
        do {
            let postCopy = post
            post.didLike = false
            post.likes -= 1
            try await PostService.unlikePost(postCopy)
        } catch {
            post.didLike = true
            post.likes += 1
        }
    }
    
    func checkIfUserLikedPost() async throws {
        self.post.didLike = try await PostService.checkIfUserLikedPost(post)
    }
    
    
    func notlike() async throws {

        do {
            let postCopy = post
            post.notdidLike = true
//            if post.notlikes == nil {
//                    post.notlikes = 0
//                }
//            post.notlikes += 1
            post.notlikes = (post.notlikes ?? 0) + 1
            try await PostService.notlikePost(postCopy)
        } catch {
            post.notdidLike = false
//            if post.notlikes == nil {
//                    post.notlikes = 0
//                }
//            post.notlikes -= 1
            post.notlikes = (post.notlikes ?? 0) - 1
        }
    }

    func notunlike() async throws {
        do {
            let postCopy = post
            post.notdidLike = false
//            if post.notlikes == nil {
//                    post.notlikes = 0
//                }
//            post.notlikes -= 1
            post.notlikes = (post.notlikes ?? 0) - 1
            try await PostService.notunlikePost(postCopy)
        } catch {
            post.notdidLike = true
//            if post.notlikes == nil {
//                    post.notlikes = 0
//                }
//            post.notlikes += 1
            post.notlikes = (post.notlikes ?? 0) + 1
        }
    }

    func notcheckIfUserLikedPost() async throws {
        self.post.notdidLike = try await PostService.notcheckIfUserLikedPost(post)
    }
}
