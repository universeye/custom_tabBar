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
        CustomTabBarItem(id: "FirstPage", view: AnyView(ResearchView())),
        CustomTabBarItem(id: "SecondPage", view: AnyView(DeploymentView())),
        CustomTabBarItem(id: "ThirdPage", view: AnyView(AnalyticsView())),
        CustomTabBarItem(id: "ForthPage", view: AnyView(AudienceView())),
        CustomTabBarItem(id: "FifthPage", view: AnyView(PrivacyView()))
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

struct ResearchView: View {
    var body: some View {
        Text("First View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct DeploymentView: View {
    var body: some View {
        Text("Second View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AnalyticsView: View {
    var body: some View {
        Text("Third View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AudienceView: View {
    var body: some View {
        Text("Forth View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PrivacyView: View {
    var body: some View {
        Text("Fifth View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Home()
}
