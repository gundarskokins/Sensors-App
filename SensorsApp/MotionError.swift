//
//  MotionError.swift
//  SensorsApp
//
//  Created by Gundars Kokins on 31/08/2020.
//  Copyright © 2020 Gundars Kokins. All rights reserved.
//

import Foundation

enum MotionError: Error {
    case motionError(String)
}

extension MotionError {
    var localizedDescription: String {
        switch self {
            case .motionError(let type):
                return "Unknown error occurred while obtaining \(type) values"
        }
    }
}
