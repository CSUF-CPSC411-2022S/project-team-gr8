//
//  ARScanner.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 3/24/22.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        return ARView(frame: .zero)
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}
