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
    static let yello = Color(red: 1, green: 250/255, blue: 205/255)
}

struct DetectView: View {
    @State private var isFindViewPresented = false
    @State private var startDetect = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    
                    
                    NavigationLink(destination: FindView(), isActive: $isFindViewPresented) {
                        
                        EmptyView()
                    }
                    
                    
                    
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                if(startDetect) {
                                    startDetect = false
                                }else {
                                    startDetect = true
                                }
                                
                            }) {
                                
                                if(startDetect) {
                                    Text("Stop Detecting")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }else {
                                    Text("Start Detecting")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                                
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: FindView()) {
                                Text("View Results")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                        }
                        
                        
                     
                        
                        ZStack {
                            Circle()
                                .fill(Color.silver)
                                .frame(width: geometry.size.width*0.75)
                            
                            Circle()
                                .fill(Color.yello)
                                .frame(width: geometry.size.width/2)
                            
                            if(startDetect) {
                                MagneticView()
                            }
                            
                        }
                        
                        Spacer()
                    }.frame(
                        maxWidth: .infinity, maxHeight: .infinity
                    )
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
        DetectView()
    }
}
