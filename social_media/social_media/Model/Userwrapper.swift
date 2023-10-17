//
//  Userwrapper.swift
//  social_media
//
//  Created by 安泓晔 on 17/10/2023.
//

import Foundation
import SwiftUI

class UserWrapper: ObservableObject {
    @Published var user: User

    init(user: User) {
        self.user = user
    }
}
