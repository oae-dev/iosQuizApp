//
//  BackGroundCurves.swift
//  RegisterScreen
//
//  Created by Dev on 29/09/25.
//

import SwiftUI

struct BackGroundCurves: View {
    var body: some View {
        MyBG()
            .rotation(Angle(degrees: 180))
            .fill(.blue.opacity(0.7))
            .ignoresSafeArea()
    }
}

#Preview {
    BackGroundCurves()
}

struct MyBG: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX , y: rect.maxY - 120))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX , y: rect.maxY - 120),
                control: CGPoint(x: rect.midX , y: rect.minY + 500)
            )
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        }
    }
}
