//
//  MotionManager.swift
//  SensorsApp
//
//  Created by Gundars Kokins on 28/08/2020.
//  Copyright © 2020 Gundars Kokins. All rights reserved.
//

import Foundation
import CoreMotion
import Combine

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    var error: Error?
    @Published var rotationValues = RotationValues()
    @Published var accelerationValues: (gravity: CMAcceleration, userAcceleration: CMAcceleration)?
    @Published var magneticFieldValues: CMCalibratedMagneticField?
    
    enum MotionType: String {
        case accelerometer
        case gyro
        case magnetometer
    }

    init() {
        //Set update intervals to 60fps
        motionManager.gyroUpdateInterval = 1/60
        motionManager.magnetometerUpdateInterval = 1/60
        motionManager.accelerometerUpdateInterval = 1/60

        motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
            guard let data = data else {
                if let error = error {
                    self.error = error
                    return
                }
                
                self.error = MotionError.motionManagerError
                return
            }
            
            

            self.rotationValues = RotationValues(pitch: data.attitude.pitch,
                                                 roll: data.attitude.roll,
                                                 yaw: data.attitude.yaw,
                                                 rotationRateX: data.rotationRate.x,
                                                 rotationRateY: data.rotationRate.y,
                                                 rotationRateZ: data.rotationRate.z)
            self.accelerationValues = (data.gravity, data.userAcceleration)
            self.magneticFieldValues = data.magneticField
        }
    }
}

struct RotationValues {
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    
    var rotationRateX = 0.0
    var rotationRateY = 0.0
    var rotationRateZ = 0.0

}


//class MotionManager: ObservableObject {
//
//    private var motionManager: CMMotionManager
//
//    @Published
//    var x: Double = 0.0
//    @Published
//    var y: Double = 0.0
//    @Published
//    var z: Double = 0.0
//
//
//    init() {
//        self.motionManager = CMMotionManager()
//        self.motionManager.magnetometerUpdateInterval = 1/60
//        self.motionManager.startMagnetometerUpdates(to: .main) { (magnetometerData, error) in
//            guard error == nil else {
//                print(error!)
//                return
//            }
//
//            if let magnetData = magnetometerData {
//                self.x = magnetData.magneticField.x
//                self.y = magnetData.magneticField.y
//                self.z = magnetData.magneticField.z
//            }
//
//        }
//
//    }
//}
