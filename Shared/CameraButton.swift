//
//  CameraButton.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 4/26/22.
//

import Foundation
import SwiftUI

struct ScanButton: UIViewRepresentable {
  @Binding var text: String

  func makeUIView(context: Context) -> UIButton {
    let textFromCamera = UIAction.captureTextFromCamera(
      responder: context.coordinator,
      identifier: nil)
    let button = UIButton()
    button.setImage(
      UIImage(systemName: "camera.badge.ellipsis"),
      for: .normal)
    button.menu = UIMenu(children: [textFromCamera])
    return button
  }

  func updateUIView(_ uiView: UIButton, context: Context) { }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: UIResponder, UIKeyInput {
    let parent: ScanButton
    init(_ parent: ScanButton) { self.parent = parent }

    var hasText = false
    func insertText(_ text: String) {
      parent.text = text
    }
    func deleteBackward() { }
  }
}
