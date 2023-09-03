//
//  AuthService.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

//验证用户和与API通信
class AuthService {
    
    //这个绘画来确认是不是登陆了
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    //实例化
    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    //登陆 - 也一样 usersession也就创建好了
    func login(withEmail email: String, password: String) async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
        
    }
    
    @MainActor
    //创建用户 - 创建后 usersession也就创建好了
    func createUser(email: String, password: String, username: String) async throws {
//        print("Email is \(email)")
//        print("Password is \(password)")
//        print("username is \(username)")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
            
        }
    }
    
    //加载用户的数据
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        
        //decode data
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
    }
    
    //登出
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        
        //要这样encode一下 不能直接上传
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        
        //传入firebase
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
