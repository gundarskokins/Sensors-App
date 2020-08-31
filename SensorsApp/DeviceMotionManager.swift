//
//  DeviceMotionManager.swift
//  SensorsApp
//
//  Created by Gundars Kokins on 31/08/2020.
//  Copyright © 2020 Gundars Kokins. All rights reserved.
//

import Foundation
import CoreMotion
import Combine

//class DeviceMotionManager: ObservableObject {
//    private let motionManager = CMMotionManager()
//
//    @Published var gyroResult: Result<CMGyroData, Error>
//    @Published var magnetometerResult: Result<CMMagnetometerData, Error>
//    @Published var accelerometerResult: Result<CMAccelerometerData, Error>
//
//    enum MotionType: String {
//        case accelerometer
//        case gyro
//        case magnetometer
//    }
//
//    init() {
//        //Set update intervals to 60fps
//        motionManager.gyroUpdateInterval = 1/60
//        motionManager.magnetometerUpdateInterval = 1/60
//        motionManager.accelerometerUpdateInterval = 1/60
//
//        motionManager.startGyroUpdates(to: .main) { (gyroData, error) in
//            self.gyroResult = self.getMotionResult(data: gyroData, error: error, type: .gyro)
//        }
//
//        motionManager.startMagnetometerUpdates(to: .main) { (magnetometerData, error) in
//            self.magnetometerResult = self.getMotionResult(data: magnetometerData, error: error, type: .magnetometer)
//        }
//
//        motionManager.startAccelerometerUpdates(to: .main) { (accelerometerData, error) in
//            self.accelerometerResult = self.getMotionResult(data: accelerometerData, error: error, type: .accelerometer)
//        }
//    }
//
//    func getMotionResult<T>(data: T?, error: Error?, type: MotionType) -> Result<T, Error> {
//        guard let data = data else {
//            if let error = error {
//                return .failure(error)
//            }
//
//            return .failure(MotionError.motionError(type.rawValue))
//        }
//
//        return .success(data)
//    }
//
//    func stopMotionManager(manager: MotionType) {
//        switch manager {
//            case .accelerometer:
//                motionManager.stopAccelerometerUpdates()
//            case .gyro:
//                motionManager.stopGyroUpdates()
//            case .magnetometer:
//                motionManager.stopMagnetometerUpdates()
//        }
//    }
//}

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
