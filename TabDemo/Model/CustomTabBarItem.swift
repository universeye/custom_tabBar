//
//  CustomTabBarItem.swift
//  TabDemo
//
//  Created by Terry Kuo on 2025/3/14.
//

import SwiftUI

struct CustomTabBarItem: Identifiable {
    let id: String
    let view: AnyView
    var size: CGSize = .zero
    var minX: CGFloat = 0
}
