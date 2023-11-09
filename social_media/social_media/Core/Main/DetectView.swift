//
//  DetectView.swift
//  social_media
//
//  Created by 安泓晔 on 17/10/2023.
//

import SwiftUI

extension Color {
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let silver = Color(red: 0.75, green: 0.75, blue: 0.75)
}

struct DetectView: View {
    @State private var isFindViewPresented = false
    
    @State private var selectedIndex = 3
    
    @State private var caption = "fe"
    
    @Binding var tabIndex: Int
    @Binding var caption1: String
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    //Color.gray.ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Color.silver)
                                .frame(width: geometry.size.width)
                            
                            Text("Detect")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        // 使用NavigationLink来实现跳转
                        NavigationLink(destination: FindView(tabIndex: $selectedIndex, caption1: $caption1), isActive: $isFindViewPresented) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            isFindViewPresented = true
                        }) {
                            Text("Start Detecting")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        Button {
                            Task {
                                caption1 = "fe"
                                tabIndex = 3
                            }
                        } label: {
                            Text("View Results")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("") // 清除默认的导航栏标题
            .navigationBarHidden(true) // 隐藏导航栏
        }
        .navigationBarBackButtonHidden(true) // 隐藏返回按钮
    }
}




struct DetectView_Previews: PreviewProvider {
    static var previews: some View {
        DetectView(tabIndex: .constant(0), caption1: .constant("fe"))
    }
}
