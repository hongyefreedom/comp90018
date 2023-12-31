//
//  FeedCell.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI
import Kingfisher
import Firebase
import CoreLocation
import Combine


func formattedDate(timestamp: Timestamp) -> String {
    let date = timestamp.dateValue()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-M-d HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC+10") // 设置时区
    
    return dateFormatter.string(from: date)
}

struct FeedCell: View {
//    let post: Post
//    @State private var isLiked: Bool = false
//    @State private var likeCount: Int
    @State private var locationName: String?
    @State private var cancellable: AnyCancellable? // 声明为 @State 变量
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    //@ObservedObject var notviewModel: NotFeedCellViewModel
    
    @State private var showComments = false
    
    var didLike: Bool { return viewModel.post.didLike ?? false }
    
    var notdidLike: Bool { return viewModel.post.notdidLike ?? false }
    
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
        //self.notviewModel = NotFeedCellViewModel(post: post)
    }
    
    private var post: Post {
        return viewModel.post
    }
    
    func getLocationName() {
        if let location = post.location {
            let geocoder = CLGeocoder()
            let locationCoordinate = location.coordinate
            let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            
            cancellable = Just(location)
                .flatMap { location in
                    Future { promise in
                        geocoder.reverseGeocodeLocation(location) { placemarks, error in
                            if let placemark = placemarks?.first {
                                if let name = placemark.name {
                                    promise(.success(name))
                                } else {
                                    promise(.success("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)"))
                                }
                            } else {
                                promise(.success("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)"))
                            }
                        }
                    }
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { name in
                    locationName = name
                })
        }
    }
    

    
    var body: some View {
        VStack {
            HStack {
                if let user = post.user {
                    NavigationLink(destination: ProfileView(user: user)
                    ){
                        CircularProfileImageView(user: user, size: .xSmall)
                        Text(user.username)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    }
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
//                Button(action: {
//                    Task { didLike ? try await viewModel.unlike() : try await viewModel.like() }
//                }, label: {
//                    Image(systemName: didLike ? "heart.fill" : "heart")
//                        .resizable()
//                        .scaledToFill()
//                        .foregroundColor(didLike ? .red : .black)
//                        .frame(width: 20, height: 20)
//                        .font(.system(size: 20))
//                        //.rotationEffect(.degrees(180)) // 旋转180度
//                        .padding(4)
//                })
                
                
                Button(action: {
                    Task { didLike ? try await viewModel.unlike() : try await viewModel.like() }
                }, label: {
                    Image(systemName: didLike ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? Color.redvine : .black)
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        //.rotationEffect(.degrees(180)) // 旋转180度
                        .padding(4)
                })
                .disabled(notdidLike) // 如果 didLike 为 true，则按钮不可点击

                Button(action: {
                    Task { notdidLike ? try await viewModel.notunlike() : try await viewModel.notlike() }
                }, label: {
                    Image(systemName: notdidLike ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? Color.redvine : .black)
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        //.rotationEffect(.degrees(180)) // 旋转180度
                        .padding(4)
                })
                .disabled(didLike) // 如果 didLike 为 true，则按钮不可点击
                
//                Text("\((post.notlikes ?? 0)) unlikes")
//                    .font(.footnote)
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 10)
//                    .padding(.top, 1)
            
                
                
                Button {
                    showComments.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                
                Spacer()
            
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)
            
//            Text("\(post.likes) likes")
//                .font(.footnote)
//                .fontWeight(.semibold)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 10)
//                .padding(.top, 1)
            
            Text("\(post.likes) likes")
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
            
            if let location = post.location {
                Group {
                    if let locationName = locationName {
                        HStack {
                            Image(systemName: "location")
                            Text(locationName)
                        }
                    } else {
                        HStack {
                            Image(systemName: "location")
                            Text("Lat: \(location.coordinate.latitude), Lon: \(location.coordinate.longitude)")
                        }
                    }
                }
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundColor(.gray)
                .onAppear {
                    getLocationName()
                }
            }
        }
        .sheet(isPresented: $showComments, content: {
            CommentsView(post: post)
                .presentationDragIndicator(.visible)
        })
        .background(Color.cream)
    }
}




//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell(post: Post.MOCK_POSTS[0])
//    }
//}
