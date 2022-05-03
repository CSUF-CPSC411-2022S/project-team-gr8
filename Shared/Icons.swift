//
//  Icons.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 5/2/22.
//

import Foundation
import SwiftUI

struct BrandsTabIcon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: (rect.maxY) * (3/4)))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 4))
    
        path.move(to: CGPoint(x: rect.maxX / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: (rect.maxY) * (3/4)))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY/2))
        path.move(to: CGPoint(x: 0, y: rect.maxY/4))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: 0))
        
        return path
    }
}

struct OctacubeIcon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let left_top = CGPoint(x: 0, y: rect.maxY / 4)
        let left_top_mid = CGPoint(x: rect.maxX / 4, y: 0)
        let right_top_mid = CGPoint(x: 3*rect.maxX / 4, y: 0)
        let right_top = CGPoint(x: rect.maxX, y: rect.maxY/4)
        let bottom_right = CGPoint(x: rect.maxX, y: 3*rect.maxY/4)
        let bottom_mid_right = CGPoint(x: 3*rect.maxX/4, y: rect.maxY)
        let bottom_mid_left = CGPoint(x: rect.maxX/4, y: rect.maxY)
        let bottom_left = CGPoint(x: 0, y: 3*rect.maxY/4)
        // octagon
        path.move(to: left_top)
        path.addLine(to: left_top_mid)
        path.addLine(to: right_top_mid)
        path.addLine(to: right_top)
        path.addLine(to: bottom_right)
        path.addLine(to: bottom_mid_right)
        path.addLine(to: bottom_mid_left)
        path.addLine(to: bottom_left)
        path.addLine(to: left_top)
        // inside octagon
        let top_mid_left_center = CGPoint(x: rect.maxX/4, y: rect.maxY/4)
        path.addLine(to: top_mid_left_center)
        path.move(to: left_top_mid)
        path.addLine(to: top_mid_left_center)
        path.move(to: bottom_left)
        let bottom_mid_left_center = CGPoint(x: rect.maxX/4, y: 3*rect.maxY/4)
        path.addLine(to:bottom_mid_left_center)
        path.move(to: bottom_mid_left)
        path.addLine(to: bottom_mid_left_center)
        
        let top_mid_right_center = CGPoint(x:3*rect.maxX/4, y: rect.maxY/4)
        path.move(to: right_top_mid)
        path.addLine(to: top_mid_right_center)
        path.addLine(to: right_top)
        let bottom_mid_right_center = CGPoint(x:3*rect.maxX/4, y: 3*rect.maxY/4)
        path.move(to: bottom_right)
        path.addLine(to: bottom_mid_right_center)
        path.addLine(to: bottom_mid_right)
        
        path.move(to: top_mid_left_center)
        path.addLine(to: bottom_mid_left_center)
        path.addLine(to: bottom_mid_right_center)
        path.addLine(to: top_mid_right_center)
        path.addLine(to: top_mid_left_center)

        
        return path
    }
}
