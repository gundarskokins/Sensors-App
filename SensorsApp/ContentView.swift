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
        
    var body: some View {
        VStack {
            Text("\(motionManager.rotationValues.pitch)")
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(motionManager: MotionManager())
    }
}
