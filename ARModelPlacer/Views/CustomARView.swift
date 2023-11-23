//
//  CustomARView.swift
//  ARModelPlacer
//
//  Created by Rajveer Singh on 19/11/23.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit
import Combine
import FocusEntity

class CustomARView: ARView {
    var focusEntity: FocusEntity?
    var cancellables = Set<AnyCancellable>()
    
    @MainActor
    required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor
    required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        subscribeToActionStream()
        
        self.setupFocusEntity()
        self.setupARView()
    }
    
    func setupARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }
        
        self.session.run(config)
    }
    
    func place3DModel() {
        guard let focusEntity = self.focusEntity else { return }
        
        let modelEntity = try! ModelEntity.loadModel(named: "toy_car.usdz")
        let anchorEntity = AnchorEntity(world: focusEntity.position)
        anchorEntity.addChild(modelEntity)
        
        self.scene.addAnchor(anchorEntity)
    }
    
    func setupFocusEntity() {
        self.focusEntity = FocusEntity(on: self, style: .classic(color: .yellow))
    }
    
    func subscribeToActionStream() {
        ActionManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .place3DModel:
                    self?.place3DModel()
                    
                case .remove3DModel:
                    print("Removing 3D Model: has not been implemented")
                }
            }
            .store(in: &cancellables)
    }
}
