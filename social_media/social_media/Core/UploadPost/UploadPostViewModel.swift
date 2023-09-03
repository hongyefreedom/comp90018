//
//  UploadPostViewModel.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
class UploadPostViewModel: ObservableObject {
    
    //通知我们某件事情已经发生
    //选一张图片
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    
    //把图片存入这里
    @Published var postImage: Image?
    
    //查看我们从PhotosPickerItem中选择的对象
    func loadImage(fromItem item: PhotosPickerItem?) async {
        
        // 这俩就是用来访问image 看看image是不是选到了
        guard let item = item else { return }
        
        // 得到image背后的数据
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        
        //创建一个UIimage，把数据放进去
        guard let uiImage = UIImage(data: data) else {return}
        
        //把它放入SwiftUI
        self.postImage = Image(uiImage: uiImage)
        
        
    }
}
