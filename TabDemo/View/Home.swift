//
//  Home.swift
//  TabDemo
//
//  Created by Terry Kuo on 2025/3/14.
//

import SwiftUI

struct Home: View {
    @State private var activeTab: String = "FirstPage"
    
    private var tabItems: [CustomTabBarItem] = [
        CustomTabBarItem(id: "FirstPage", view: AnyView(FirstView())),
        CustomTabBarItem(id: "SecondPage", view: AnyView(SecondView())),
        CustomTabBarItem(id: "ThirdPage", view: AnyView(ThirdView())),
        CustomTabBarItem(id: "ForthPage", view: AnyView(ForthView())),
        CustomTabBarItem(id: "FifthPage", view: AnyView(FifthView()))
    ]
    
    var body: some View {
        CustomTabBar(activeTab: $activeTab, items: tabItems) {
            HStack(spacing: 0) {
                ForEach(tabItems) { item in
                    item.view
                        .id(item.id)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct FirstView: View {
    var body: some View {
        Image(systemName: "macpro.gen1")
            .font(.system(size: 150, weight: .medium, design: .rounded))
    }
}

struct SecondView: View {
    var body: some View {
        Image(systemName: "macpro.gen2")
            .font(.system(size: 150, weight: .medium, design: .rounded))
    }
}

struct ThirdView: View {
    var body: some View {
        Image(systemName: "macbook")
            .font(.system(size: 150, weight: .medium, design: .rounded))
    }
}

struct ForthView: View {
    var body: some View {
        Image(systemName: "macpro.gen3")
            .font(.system(size: 150, weight: .medium, design: .rounded))
    }
}

struct FifthView: View {
    var body: some View {
        Image(systemName: "vision.pro.fill")
            .font(.system(size: 150, weight: .medium, design: .rounded))
    }
}

#Preview {
    Home()
}
