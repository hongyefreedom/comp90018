//
//  GridView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI
import Kingfisher

struct GridView: View {
    
    //var posts: [Post]
    //let user: User
    @StateObject var viewModel: PostGridViewModel
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    //创建三个grid对象 有灵活的尺寸和一个像素
    //列间距
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            
            // id 给每个图一个id
            ForEach(viewModel.posts){ post in
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView( user: User.MOCK_USERS[0])
    }
}
