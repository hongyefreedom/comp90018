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
    static let fae = Color(red: 212/255, green: 186/255, blue: 176/255)
    static let orange1 = Color(red: 127/255, green: 134/255, blue: 123/255)
    static let orchid = Color(red: 193/255, green:171/255, blue: 173/255)
    static let matcha = Color(red: 199/255, green: 199/255, blue: 187/255)
    static let cream = Color(red: 239/255, green: 237/255, blue: 231/255)
    static let grey1 = Color(red: 164/255, green: 163/255, blue: 161/255)
    static let periwinkle = Color(red: 157/255, green: 162/255, blue: 174/255)
    static let oxford = Color(red: 41/255, green: 50/255, blue: 66/255)
    static let antique = Color(red: 240/255, green: 231/255, blue: 218/255)
    static let rosehip = Color(red: 229/255, green: 203/255, blue: 193/255)
    static let redvine = Color(red: 186/255, green: 73/255, blue: 75/255)
    static let green1 = Color(red: 127/255, green: 140/255, blue: 124/255)
    static let yellow1 = Color(red: 198/255, green: 175/255, blue: 117/255)
    static let golden = Color(red: 220/255, green: 195/255, blue: 149/255)
}


struct DetectView: View {

    @State var isSeeking = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
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
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                     
                        

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




struct DetectView_Previews: PreviewProvider {
    static var previews: some View {
        DetectView()
    }
}

