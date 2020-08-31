//
//  ContentView.swift
//  SensorsApp
//
//  Created by Gundars Kokins on 28/08/2020.
//  Copyright © 2020 Gundars Kokins. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var motionManager: MotionManager
    @State var stopSensors = false
        
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Change update interval")
                    Slider(value: $motionManager.updateInterval, in: -1...1, step: 0.005)
                }
                .padding()
                
                Form {
                    Section(header: Text("Gyro values")) {
                        VStack(alignment: .leading) {
                            DataCell(cellName: "pitch:", cellData: motionManager.gyroValues.pitch)
                            DataCell(cellName: "roll:", cellData: motionManager.gyroValues.roll)
                            DataCell(cellName: "yaw:", cellData: motionManager.gyroValues.yaw)
                            
                            DataCell(cellName: "X rotation:", cellData: motionManager.gyroValues.rotationRateX)
                            DataCell(cellName: "Y rotation:", cellData: motionManager.gyroValues.rotationRateY)
                            DataCell(cellName: "Z rotation:", cellData: motionManager.gyroValues.rotationRateZ)
                        }
                    }
                    
                    Section(header: Text("Accelerometer values")) {
                        VStack(alignment: .leading) {
                            DataCell(cellName: "user acceleration X:", cellData: motionManager.accelerationValues.userAccelerationX)
                            DataCell(cellName: "user acceleration Y:", cellData: motionManager.accelerationValues.userAccelerationY)
                            DataCell(cellName: "user acceleration Z:", cellData: motionManager.accelerationValues.userAccelerationZ)
                            
                            DataCell(cellName: "gravity X:", cellData: motionManager.accelerationValues.gravityX)
                            DataCell(cellName: "gravity Y:", cellData: motionManager.accelerationValues.gravityY)
                            DataCell(cellName: "gravity Z:", cellData: motionManager.accelerationValues.gravityZ)
                        }
                    }
                    
                    Section(header: Text("Magnetometer values")) {
                        VStack(alignment: .leading) {
                            DataCell(cellName: "magnetic field X:", cellData: motionManager.magneticFieldValues.magneticFieldX)
                            DataCell(cellName: "magnetic field Y:", cellData: motionManager.magneticFieldValues.magneticFieldY)
                            DataCell(cellName: "magnetic field Z:", cellData: motionManager.magneticFieldValues.magneticFieldZ)
                        }
                    }
                }
                
                
                HStack(alignment: .center) {
                    if stopSensors {
                        Button(action: {
                            self.motionManager.stopMotionManager()
                            self.stopSensors = false
                        }) {
                            Text("Stop sensors")
                                .fontWeight(.semibold)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                        }
                    } else {
                        Button(action: {
                            self.motionManager.startMotionManager()
                            self.stopSensors = true
                        }) {
                            Text("Start sensors")
                                .fontWeight(.semibold)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                            
                        }
                    }
                }
                .padding()
                
            }
            .navigationBarTitle("Motion sensor info")
            .alert(isPresented: self.$motionManager.showError) {
                if let error = motionManager.error {
                    return Alert(title: Text("Ooops.."), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                }
                return Alert(title: Text("Ooops.."), message: Text("Something went wrong"), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(motionManager: MotionManager())
    }
}
