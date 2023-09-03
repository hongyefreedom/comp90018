//
//  LoginViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
