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
            }
        }
    }
}

struct FirstView: View {
    var body: some View {
        Text("First View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Third View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ForthView: View {
    var body: some View {
        Text("Forth View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FifthView: View {
    var body: some View {
        Text("Fifth View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Home()
}
