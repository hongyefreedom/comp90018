//
//  FindView.swift
//  social_media
//
//  Created by 安泓晔 on 17/10/2023.
//

import SwiftUI


struct FindView: View {
    @State private var isDetectViewPresented = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    //Color.gray.ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        MagneticFindView()
                        
                        Spacer()
                        
                        NavigationLink(destination: DetectView(), isActive: $isDetectViewPresented) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            isDetectViewPresented = true
                        }) {
                            Text("Start Finding")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        NavigationLink(destination: DetectView()) {
                            Text("View Detect Results")
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
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true) // 隐藏返回按钮
    }
}


struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}
