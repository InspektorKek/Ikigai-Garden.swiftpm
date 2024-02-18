//
//  ARViewContainer.swift
//  
//
//  Created by mikhailborisov on 2/18/24.
//

import RealityKit
import SwiftUI
import UIKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        
        config.planeDetection = [.horizontal, .vertical]
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
//        coachingOverlay.delegate = arView
        arView.addSubview(coachingOverlay)
        arView.session.run(config)
        
        return arView
        
    }
}

