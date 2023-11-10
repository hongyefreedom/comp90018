//
//  SwiftUIView.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/7.
//

import SwiftUI
import CoreMotion
import AudioToolbox



class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var magneticField: CMMagneticField = CMMagneticField(x: 0, y: 0, z: 0)

    init() {
        if motionManager.isMagnetometerAvailable {
            motionManager.startMagnetometerUpdates(to: .main) { (data, error) in
                if let data = data {
                    self.magneticField = data.magneticField
                }
            }
        }
    }
}



struct MagneticView: View {
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @StateObject private var motionManager = MotionManager()
    @State private var magneticValue = MotionManager().magneticField
    @State private var preMagneticValue = MotionManager().magneticField
    @State private var rotation: Double = 0
    
    @State var isStart = false;
    
    func onPress() {
        if(isStart) {
            isStart = false
            withAnimation {
                rotation = 0
            }
        }else {
            isStart = true
            withAnimation(Animation.linear(duration: 7.5).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }

    var body: some View {
        
        NavigationView  {
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
                
                if(isStart) {
                    VStack{
                        Text("Magnetic: \(String(format: "%.2f", (magneticValue.x+magneticValue.y+magneticValue.z))) μT")
                            .onReceive(timer) { _ in
                                
                                magneticValue = motionManager.magneticField
                                let delta = sqrt(
                                    pow(magneticValue.x - preMagneticValue.x, 2) +
                                    pow(magneticValue.y - preMagneticValue.y, 2) +
                                    pow(magneticValue.z - preMagneticValue.z, 2)
                                )
                                
                                if(delta > 50) {
                                    AudioServicesPlaySystemSound(1005)
                                }
                                
                                preMagneticValue = magneticValue
                                
                            }
                        Text("Stop")
                    }
                    
                    
                }else {
                    Text("Start")
                }
              
            }
            .background(Color.cream)
        }

    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MagneticView()
    }
}
