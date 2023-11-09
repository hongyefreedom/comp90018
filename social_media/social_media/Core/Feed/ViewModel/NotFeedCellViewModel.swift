////
////  NotFeedCellViewModel.swift
////  social_media
////
////  Created by 安泓晔 on 25/10/2023.
////
//
//import SwiftUI
//import Firebase
//
//@MainActor
//class NotFeedCellViewModel: ObservableObject {
//    @Published var post: Post
//    
//    init(post: Post) {
//        self.post = post
//        Task { try await notcheckIfUserLikedPost() }
//    }
//    
//    func notlike() async throws {
//        
//        do {
//            let postCopy = post
//            post.notdidLike = true
//            post.notlikes += 1
//            try await PostService.notlikePost(postCopy)
//        } catch {
//            post.notdidLike = false
//            post.notlikes -= 1
//        }
//    }
//    
//    func notunlike() async throws {
//        do {
//            let postCopy = post
//            post.notdidLike = false
//            post.notlikes -= 1
//            try await PostService.notunlikePost(postCopy)
//        } catch {
//            post.notdidLike = true
//            post.notlikes += 1
//        }
//    }
//    
//    func notcheckIfUserLikedPost() async throws {
//        self.post.notdidLike = try await PostService.notcheckIfUserLikedPost(post)
//    }
//}
