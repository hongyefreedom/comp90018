//
//  UserListViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        //Task {try await fetchAllUsers()}
    }
    
    func fetchUsers(forConfig config: UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        } catch {
            
        }
        
    }
}
