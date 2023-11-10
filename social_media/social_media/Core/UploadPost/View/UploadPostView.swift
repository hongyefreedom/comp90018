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
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    @StateObject var viewModel = UploadPostViewModel()
    
    @Binding var tabIndex: Int
    
    @State private var canPost = false
    @State private var isUploading = false
    
    
    var body: some View {
        
        ZStack {
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
                            
                            canPost = true
                            isUploading = true // 开始上传时显示加载动画
                            
                            try await viewModel.uploadPost(caption: caption)
                            clearPostDataAndReturnToFeed()
                            
                            //refresh posts
                            try await feedViewModel.fetchPosts()
                            
                            // 结束上传，隐藏加载动画
                            isUploading = false
                            canPost = false
                        }
                    } label: {
                        Text("Upload")
                            .fontWeight(.semibold)
                    }
                    .disabled(canPost)
                    
                }
                .padding(.horizontal)
                
                HStack(spacing: 12) {
                    
                    if let image = viewModel.postImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                    }
                    
                    TextField("Enter your caption...", text: $caption, axis: .vertical)
                }
                .padding()
                
                Spacer()
                
                if isUploading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                        .padding(50)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .onAppear{
                imagePickerPresented.toggle()
            }
            .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        }
        
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
