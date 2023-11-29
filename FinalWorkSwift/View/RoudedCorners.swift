//
//  RoudedCorners.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 16/10/23.
//

import SwiftUI

struct RoudedCorners: Shape {
    var corners: UIRectCorner = .allCorners
    var radius: CGFloat = .infinity
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
