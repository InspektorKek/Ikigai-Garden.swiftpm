import RealityKit
import SwiftUI
import UIKit
import ARKit

struct ARMeditationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ARMeditationViewContainer()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            MusicPlayer.shared.startBackgroundMusic(withFileName: "sixsense", loopingType: .one) {
                // audio completed
            }
        }
        .onDisappear {
            MusicPlayer.shared.startBackgroundMusic(withFileName: "background_music_main", loopingType: .infinite)
        }
    }
}

struct ARMeditationViewContainer: UIViewRepresentable {
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

