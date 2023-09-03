//
//  SearchViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
