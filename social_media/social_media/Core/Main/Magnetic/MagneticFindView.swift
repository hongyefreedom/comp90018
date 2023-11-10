//
//  MagneticFindView.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/10.
//

import SwiftUI
import Firebase

struct MagneticFindView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject private var motionManager = MotionManager()
    @State private var  magneticValue = MotionManager().magneticField
    @State private var preMagneticValue = MotionManager().magneticField
    @State private var isStart = false
    @State private var count = 0
    @State private var noResultAlert = false
    @State private var resultAlert = false
    @State private var rotation: Double = 0
    @State private var navigateToNextPage = false
    
    let maxCount = 5
    
    func onPress() {
        if(isStart) {
            isStart = false
            
            withAnimation {
                rotation = 0
            }
            
            
        }else {
            isStart = true
            count = 0
            
            preMagneticValue = motionManager.magneticField
            withAnimation(Animation.linear(duration: 7.5).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("spinner")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                    .rotationEffect(.degrees(rotation))
                    
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 180)
                    .onTapGesture{
                        onPress()
                    }
                    .onReceive(timer) { _ in
                        
                        if(isStart) {
                            count += 1
                            if(count >= maxCount) {
                                onPress()
                                noResultAlert = true
                            }
                            
                            magneticValue = motionManager.magneticField
                            
                            let delta = sqrt(
                                pow(magneticValue.x - preMagneticValue.x, 2) +
                                pow(magneticValue.y - preMagneticValue.y, 2) +
                                pow(magneticValue.z - preMagneticValue.z, 2)
                            )
                            
                            if(delta == 0) {
                                onPress()
                                navigateToNextPage = true
                            }
                        }
                    }
                    
                    .alert("No Result", isPresented: $noResultAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Please Try Again.")
                    }
                
                    
                
                if(isStart) {
                    Text("Stop")
                }else {
                    Text("Start")
                }
                
                NavigationLink("",destination:
                                RecordDetailView(record: DetectionRecordModel.createRecord(magValue: magneticValue, baseValue: preMagneticValue), showSave: true),
                               isActive: $navigateToNextPage
               )
                
                
                    
            }.padding()
        }
    }
}

struct MagneticFindView_Previews: PreviewProvider {
    static var previews: some View {
        MagneticFindView()
    }
}
