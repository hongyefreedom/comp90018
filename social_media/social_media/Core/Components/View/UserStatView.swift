//
//  UserStatView.swift
//  social_media
//
//  Created by 安泓晔 on 29/8/2023.
//

import SwiftUI

struct UserStatView: View {
    
    let value: Int
    let title: String
    
    
    var body: some View {
        
        VStack{
            
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Text("\(title)")
                .font(.footnote)
            
        }
        .frame(width: 87)
    }
}

// 类似实例化上面的东西
struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 12, title: "Posts")
    }
}
