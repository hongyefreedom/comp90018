//
//  UploadPostViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import CoreLocation

@MainActor
class UploadPostViewModel: ObservableObject {
    
    //通知我们某件事情已经发生
    //选一张图片
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    
    //把图片存入这里
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    
    
    private var locationManager: CLLocationManager

    init() {
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    
// @EnvironmentObject var feedViewModel: FeedViewModel
    
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
        self.postImage = Image(uiImage: uiImage)
        
        
    }
    
    
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }

        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }

        // 获取当前地理位置信息
        let currentLocation: CLLocation?
        if let location = locationManager.location {
            currentLocation = location
        } else {
            // 如果无法获取地理位置，将location赋值为 Melbourne 的经纬度
            let melbourneLatitude = -37.8136
            let melbourneLongitude = 144.9631
            currentLocation = CLLocation(latitude: melbourneLatitude, longitude: melbourneLongitude)
        }

        // 创建一个空的 Post 对象
        var post = Post(
            id: postRef.documentID,
            ownerUid: uid,
            caption: caption,
            likes: 0,
            imageUrl: imageUrl,
            timestamp: Timestamp(),
            location: currentLocation,
            notlikes: 0
        )

        // 现在将 post 存储到 Firestore
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        try await postRef.setData(encodedPost)
    }

}
