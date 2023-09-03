//
//  UserService.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import Foundation
import Firebase
struct UserService {
    
    //把数据库里的东西变成array
    static func fetchAllUsers() async throws -> [User] {
        //var users = [User]()
        
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let documents = snapshot.documents
        
//        for doc in documents {
//            guard let user = try? doc.data(as: User.self) else { return users }
//            users.append(user)
//        }
        
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}
