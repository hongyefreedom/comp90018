//
//  FindView.swift
//  social_media
//
//  Created by 安泓晔 on 17/10/2023.
//

import SwiftUI


struct FindView: View {
    
    @State var isSeeking = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    
                    VStack {
                        
                        if(!isSeeking) {
                            Text("Detecting Mode").font(.title)
                            MagneticFindView()
                            
                            Button("Change To Seeking Mode"){
                                isSeeking = true
                            }.font(.title)
                                .bold()
                                .foregroundColor(Color.orange1)
                                .padding()
                                .background(Color.fae)
                                .cornerRadius(10)
                                //.padding(.horizontal)
                                
                        }else {
                            Text("Seeking Mode").font(.title)
                            MagneticView()
                            
                            Button("Change To Detection Mode"){
                                isSeeking = false
                            }.font(.title)
                                .bold()
                                .foregroundColor(Color.orange1)
                                .padding()
                                .background(Color.fae)
                                .cornerRadius(10)
                                //.padding(.horizontal)
                        }
                        

                    }
                }
                .background(Color.cream)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color.cream)
            
            
        }
        .navigationBarBackButtonHidden(true) // 隐藏返回按钮
        .background(Color.cream)
    }
}


struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}
