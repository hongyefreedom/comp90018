//
//  CommentCell.swift
//  social_media
//
//  Created by 安泓晔 on 25/10/2023.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    //let comment: Comment
    
    private var user: User {
        return User.MOCK_USERS[0]
    }
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .xSmall)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user.username)
                        .fontWeight(.semibold)
                    
//                    Text(comment.timestamp.timestampString())
//                        .foregroundColor(.gray)
                }
                
                Text("xxxxx")
            }
            .font(.caption)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell()
    }
}
