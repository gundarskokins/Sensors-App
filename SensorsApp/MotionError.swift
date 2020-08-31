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
    case motionManagerError
}

extension MotionError {
    var localizedDescription: String {
        switch self {
            case .motionError(let type):
                return "Unknown error occurred while obtaining \(type) value"
            case .motionManagerError:
                return "Unknown error occurred while obtaining device motion values"
        }
    }
}
