//
//  EditProfileViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 3/9/2023.
//

import PhotosUI
import Firebase
import SwiftUI

@MainActor
class EditProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    //通知我们某件事情已经发生
    //选一张图片
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    
    //把图片存入这里
    @Published var profileImage: Image?
    
    @Published var fullname = ""
    @Published var bio = ""
    
    private var uiImage: UIImage?
    
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    //查看我们从PhotosPickerItem中选择的对象
    func loadImage(fromItem item: PhotosPickerItem?) async {
        
        // 这俩就是用来访问image 看看image是不是选到了
        guard let item = item else { return }
        
        // 得到image背后的数据
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        
        //创建一个UIimage，把数据放进去
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        
        //把它放入SwiftUI
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        // update image if changed
        
        
        // 字典
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            //图片传上去之后，返回url - 存入数据库
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        // update name if changed
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
