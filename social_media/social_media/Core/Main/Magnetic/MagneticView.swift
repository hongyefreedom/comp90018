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
    
    @StateObject var motionManager = MotionManager()
    @State var magneticValue = 0.0
    @State var preMagneticValue = 0.0

    var body: some View {
        VStack {
            Text("Magnetic: \(magneticValue)")
                .onReceive(timer) { _ in
                    preMagneticValue = magneticValue
                    magneticValue = motionManager.magneticField.x + motionManager.magneticField.y + motionManager.magneticField.z
                    
                    if(abs(magneticValue - preMagneticValue) > 50) {
                        AudioServicesPlaySystemSound(1005)
                    }
                    
                    
                }
            
                        

        }.padding()
        
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MagneticView()
    }
}
