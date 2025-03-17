import SwiftUI



struct CustomTabBar<Content: View>: View {
    @Binding var activeTab: String
    @State private var items: [CustomTabBarItem]
    let content: Content
    @State private var tabScrollState: String?
    @State private var mainViewScrollState: String?
    @State private var progress: CGFloat = .zero {
        didSet {
            updateCurrentTabFromProgress()
            if let progressBinding = progressBinding {
                progressBinding.wrappedValue = progress
            }
        }
    }
    @State private var indicatorScale: CGFloat = 1
    @Binding var currentTabItem: CustomTabBarItem?
    private var progressBinding: Binding<CGFloat>?
    
    
    
    init(
        activeTab: Binding<String>,
        currentTabItem: Binding<CustomTabBarItem?> = .constant(nil),
        progress: Binding<CGFloat>? = nil,
        items: [CustomTabBarItem],
        @ViewBuilder content: () -> Content
    ) {
        self._activeTab = activeTab
        self._currentTabItem = currentTabItem
        self.progressBinding = progress
        self.items = items
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            tabBar
            
            GeometryReader { geo in
                let size = geo.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        content
                            .frame(width: size.width * CGFloat(items.count))
                    }
                    .scrollTargetLayout()
                    .rect { rect in
                        let newProgress = -rect.minX / size.width
                        
                        if abs(newProgress - progress) > 0.01 {
                            progress = newProgress
                            print("Progress: \(progress), Current Tab Index: \(Int(round(progress)))")
                        }
                    }
                }
                .scrollPosition(id: $mainViewScrollState)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
            }
        }
    }
    
    private var tabBar: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach($items) { $item in
                    Button(action: {
                        withAnimation(.snappy) {
                            mainViewScrollState = item.id
                        }
                    }) {
                        Text(item.id)
                            .padding(.vertical, 12)
                            .bold()
                            .foregroundStyle(activeTab == item.id ? Color.primary : .gray)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .rect { rect in
                        item.size = rect.size
                        item.minX = rect.minX
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: .init(get: {
            return tabScrollState
        }, set: { _ in
            
        }), anchor: .center)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .frame(height: 1)
                
                let inputRange = items.indices.compactMap { return CGFloat($0) }
                let outputRange = items.compactMap { return $0.size.width }
                let outputPositionRange = items.compactMap { return $0.minX }
                
                let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: outputRange)
                let indicatorPosition = progress.interpolate(inputRange: inputRange, outputRange: outputPositionRange)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(.cyan)
                    .frame(width: indicatorWidth, height: 4.5)
                    .scaleEffect(x: indicatorScale)
                    .offset(x: indicatorPosition)
            }
        }
        .safeAreaPadding(.horizontal, 15)
        .scrollIndicators(.hidden)
    }
    
    
    private func updateCurrentTabFromProgress() {
        let roundedProgress = round(progress)
        let distanceFromInteger = abs(progress - roundedProgress)
        withAnimation(.smooth(duration: 0.4)) {
            indicatorScale = 0.4
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.smooth(duration: 0.28)) {
                indicatorScale = 1
            }
        }
        if distanceFromInteger < 0.1 {
            let index = Int(roundedProgress)
            if index >= 0 && index < items.count {
                let item = items[index]
                if activeTab != item.id {
                    withAnimation(.snappy) {
                        activeTab = item.id
                        tabScrollState = item.id
                        currentTabItem = item
                    }
                }
            }
        }
    }
}
