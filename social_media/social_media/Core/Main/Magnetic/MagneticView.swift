//
//  SwiftUIView.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/7.
//

import SwiftUI
import CoreMotion


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
    @StateObject var motionManager = MotionManager()

    var body: some View {
        VStack {
            Text("Magnetic Field:")
            Text("X: \(motionManager.magneticField.x)")
            Text("Y: \(motionManager.magneticField.y)")
            Text("Z: \(motionManager.magneticField.z)")
        }.padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MagneticView()
    }
}
