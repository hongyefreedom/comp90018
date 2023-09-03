//
//  AuthService.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation
import FirebaseAuth

//验证用户和与API通信
class AuthService {
    
    //这个绘画来确认是不是登陆了
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        //检查是否用户登陆了
        self.userSession = Auth.auth().currentUser
    }
    
    //登陆 - 也一样 usersession也就创建好了
    func login(withEmail email: String, password: String) async throws {
        
    }
    
    //创建用户 - 创建后 usersession也就创建好了
    func createUser(email: String, password: String, username: String) async throws {
        
    }
    
    //加载用户的数据
    func loadUserData() async throws {
        
    }
    
    //登出
    func signout() {
        
    }
}
