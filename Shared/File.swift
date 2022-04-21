//
//  File.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 4/21/22.
//

import Foundation
import RealityKit
import SwiftUI

struct ARViewContainer : UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}
