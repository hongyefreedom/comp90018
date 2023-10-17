//
//  FeedCell.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI
import Kingfisher
import Firebase

func formattedDate(timestamp: Timestamp) -> String {
    let date = timestamp.dateValue()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-M-d HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC+10") // 设置时区
    
    return dateFormatter.string(from: date)
}

struct FeedCell: View {
    
    let post: Post
    @State private var isLiked: Bool = false
    @State private var likeCount: Int
    
    init(post: Post) {
        self.post = post
        self._likeCount = State(initialValue: post.likes)
    }

    var body: some View {
        VStack {
            HStack {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .xSmall)
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(.leading, 8)
            
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            HStack(spacing: 16) {
                Button {
                    isLiked.toggle()
                    if isLiked {
                        likeCount += 1
                    } else {
                        likeCount -= 1
                    }
                    print("Like post")
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(isLiked ? Color.red : Color.primary)
                }
                
                Button {
                    print("Comment on post")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button {
                    print("Share post")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)
            
            Text("\(likeCount) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
            
            HStack {
                Text("\(post.user?.username ?? "") ").fontWeight(.semibold) +
                Text(post.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.top, 1)
            .font(.footnote)
            
            Text("\(formattedDate(timestamp: post.timestamp))")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundColor(.gray)
        }
    }
}



//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell(post: Post.MOCK_POSTS[0])
//    }
//}
