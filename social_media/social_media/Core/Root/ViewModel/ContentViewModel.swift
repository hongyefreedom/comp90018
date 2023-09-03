//
//  ContentViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject {
    
    //监听shared，要确保登陆或注册 都是这个
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        setupSubscribers()
    }
    
    func setupSubscribers() {
        //这就是listen
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
