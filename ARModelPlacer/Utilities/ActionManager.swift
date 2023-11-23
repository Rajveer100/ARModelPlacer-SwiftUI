//
//  ActionManager.swift
//  ARModelPlacer
//
//  Created by Rajveer Singh on 19/11/23.
//

import Foundation
import SwiftUI
import ARKit
import RealityKit
import Combine
import FocusEntity

class ActionManager {
    static let shared = ActionManager()
    
    private init() { }
    
    var actionStream = PassthroughSubject<Actions, Never>()
}

enum Actions {
    case place3DModel
    case remove3DModel
}
