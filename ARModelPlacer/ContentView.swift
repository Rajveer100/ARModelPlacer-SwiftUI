//
//  ContentView.swift
//  ARModelPlacer
//
//  Created by Rajveer Singh on 18/11/23.
//

import SwiftUI
import RealityKit
import ARKit
import Combine
import FocusEntity

struct ContentView : View {
    let modelNames: [String] = ["fender_stratocaster",
                                "pancakes", "robot_walk_idle",
                                "sneaker_airforce",
                                "toy_biplane_idle",
                                "toy_car",
                                "toy_drummer_idle",
                                "tv_retro"]
    
    @State private var selectedModelIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            CustomARViewContainer()
            
            Button {
                ActionManager.shared.actionStream.send(.place3DModel)
            } label: {
                Text("Place 3D Model")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            .padding(.bottom, 50)
        })
    }
}

struct CustomARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) { }
}

#Preview {
    ContentView()
}
