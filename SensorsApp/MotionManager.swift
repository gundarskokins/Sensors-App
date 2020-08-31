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
    
    var updateInterval: Double = 1/60 {
        didSet(newValue) {
            motionManager.magnetometerUpdateInterval = newValue
            motionManager.deviceMotionUpdateInterval = newValue
        }
    }
    @Published var showError = false
    @Published var gyroValues = RotationModel()
    @Published var accelerationValues = AccelerationModel()
    @Published var magneticFieldValues = MagneticFieldModel()
    
    enum MotionType: String {
        case accelerometerAndGyro = "accelerometer and gyro"
        case magnetometer
    }

    init() {
        motionManager.magnetometerUpdateInterval = updateInterval
        motionManager.deviceMotionUpdateInterval = updateInterval
    }
    
    func startMotionManager() {
        motionManager.showsDeviceMovementDisplay = true

        motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
            let result = self.getMotionResult(data: data, error: error, type: .accelerometerAndGyro)
            switch result {
                case .success(let data):
                    self.gyroValues = RotationModel(pitch: data.attitude.pitch,
                                                    roll: data.attitude.roll,
                                                    yaw: data.attitude.yaw,
                                                    rotationRateX: data.rotationRate.x,
                                                    rotationRateY: data.rotationRate.y,
                                                    rotationRateZ: data.rotationRate.z)
                    
                    self.accelerationValues = AccelerationModel(userAccelerationX: data.userAcceleration.x,
                                                                userAccelerationY: data.userAcceleration.y,
                                                                userAccelerationZ: data.userAcceleration.z,
                                                                gravityX: data.gravity.x,
                                                                gravityY: data.gravity.y,
                                                                gravityZ: data.gravity.z)
                case .failure(let error):
                    self.showError = true
                    self.error = error
            }
        }
        
        // Magnetometer not working called from startDeviceMotionUpdates function
        motionManager.startMagnetometerUpdates(to: .main) { (data, error) in
            let result = self.getMotionResult(data: data, error: error, type: .magnetometer)
            switch result {
                case .success(let data):
                    self.magneticFieldValues = MagneticFieldModel(magneticFieldX: data.magneticField.x,
                                                                  magneticFieldY: data.magneticField.y,
                                                                  magneticFieldZ: data.magneticField.z)
                case .failure(let error):
                    self.showError = true
                    self.error = error
            }
        }
    }
    
    func getMotionResult<T>(data: T?, error: Error?, type: MotionType) -> Result<T, Error> {
        guard let data = data else {
            if let error = error {
                return .failure(error)
            }
            
            return .failure(MotionError.motionError(type.rawValue))
        }
        
        return .success(data)
    }
    
    func stopMotionManager() {
        motionManager.stopDeviceMotionUpdates()
        motionManager.stopMagnetometerUpdates()
    }
}
