//
//  UploadPostView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    
    @State private var caption = ""
    @State private var imagePickerPresented = false
    
    //这个view model负责访问并上传图片
    @StateObject var viewModel = UploadPostViewModel()
    
    // 和另外某个绑定
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    clearPostDataAndReturnToFeed()
                    
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.uploadPost(caption: caption)
                        clearPostDataAndReturnToFeed()
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
                
            }
            .padding(.horizontal)
            
            HStack(spacing: 12) {
                
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        //随意缩放 - 放入格子 - 剪掉多余
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                
                TextField("Enter your caption...", text: $caption, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear{
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    func clearPostDataAndReturnToFeed() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}
