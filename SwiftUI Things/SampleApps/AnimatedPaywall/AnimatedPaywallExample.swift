// Credits: Kavsoft
// https://www.youtube.com/watch?v=6Kb8NWE8DXE

import SwiftUI
import StoreKit

struct AnimatedPaywallExample: View {
    
    static var productIDs: [String] {
        ["pro_weekly", "pro_monthly", "pro_yearly"]
    }
    
    static var points: [PaywallPoint] = [
        .init(symbol: "star", content: "High-quality premium templates"),
        .init(symbol: "arrow.up.circle", content: "Download unlimited PNGs"),
        .init(symbol: "paintbrush", content: "Exclusive customizable designs"),
        .init(symbol: "lock.open", content: "Unlock everything with premium"),
    ]
    
    @State private var isCompact = false
    @State private var showPaywall = false
    
    @ViewBuilder
    func AppInformationView() -> some View {
        VStack(spacing: 15) {
            VStack(alignment: .trailing, spacing: 0) {
                Text("App name")
                    .font(.title.bold())
                
                Text("Premium")
                    .font(.caption.bold())
                    .foregroundStyle(.background)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.primary, in: .capsule)
                    .offset(x: 5)
            }
            .lineLimit(1)
            .padding(.top, 10)
            
            Image(systemName: "apple.logo")
                .font(.system(size: 60))
                .foregroundStyle(.background)
                .frame(width: 100, height: 100)
                .background(Color.primary, in: .rect(cornerRadius: 25))
                .padding(.vertical, 25)
        }
    }
    
    @ViewBuilder
    func LinksView() -> some View {
        HStack(spacing: 5) {
            Link("Terms of Service", destination: URL(string: "https://apple.com")!)
            
            Text("&")
            
            Link("Privacy Policy", destination: URL(string: "https://apple.com")!)
        }
        .font(.caption)
        .foregroundStyle(.gray)
    }
    
    var body: some View {
        List {
            Toggle("Compact", isOn: $isCompact)
            
            Button("Show Paywall") {
                showPaywall.toggle()
            }
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView(isCompact: isCompact, ids: Self.productIDs, points: Self.points) {
                AppInformationView()
            } links: {
                LinksView()
            } loadingView: {
                ProgressView()
            }
            .tint(.primary)
            .interactiveDismissDisabled()
            .onInAppPurchaseStart { product in
                print("Purchasing \(product.displayName)")
            }
            .onInAppPurchaseCompletion { product, result in
                print(result)
            }
            .subscriptionStatusTask(for: "2C542CDC") { _ in
                print("Check for subscription status")
            }
        }
    }
}

private struct PaywallView<Header: View, Links: View, Loader: View>: View {
    
    var isCompact: Bool
    var ids: [String]
    var points: [PaywallPoint]
    @ViewBuilder var header: Header
    @ViewBuilder var links: Links
    @ViewBuilder var loadingView: Loader
    @State private var isLoaded: Bool = false
    
    @ViewBuilder
    func MarketingContent() -> some View {
        VStack(spacing: 15) {
            header
            
            if isLoaded {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(points.indices, id: \.self) { index in
                        let point = points[index]
                        AnimatedPointView(index: index, point: point)
                    }
                }
                .transition(.identity)
            }
            
            Spacer(minLength: 0)
        }
        .padding([.horizontal, .top], 15)
    }
    
    var body: some View {
        SubscriptionStoreView(productIDs: ids, marketingContent: {
            MarketingContent()
        })
//        .subscriptionStoreControlStyle(.pagedProminentPicker, placement: .scrollView)i
//        .subscriptionStoreControlStyle(.compactPicker, placement: .scrollView)
        .subscriptionStoreControlStyle(CustomSubscriptionStyle(isCompact: isCompact, links: {
            links
        }, isLoaded: {
            isLoaded = true
        }), placement: .scrollView)
        .storeButton(.hidden, for: .policies)
        .storeButton(.visible, for: .restorePurchases)
        .animation(.easeInOut(duration: 0.35)) { content in
            content
                .opacity(isLoaded ? 1 : 0)
        }
        .overlay {
            ZStack {
                if !isLoaded {
                    loadingView
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.35), value: isLoaded)
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
    }
}

private struct CustomSubscriptionStyle<Links: View>: SubscriptionStoreControlStyle {
    
    var isCompact: Bool
    @ViewBuilder var links: Links
    var isLoaded: () -> ()
    
    var isiOS26: Bool {
        if #available(iOS 26, *) {
            return true
        }
        return false
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 10) {
            VStack(spacing: 25) {
                if isCompact {
                    CompactPickerSubscriptionStoreControlStyle()
                        .makeBody(configuration: configuration)
                } else {
                    PagedProminentPickerSubscriptionStoreControlStyle()
                        .makeBody(configuration: configuration)
                }
            }
            
            links
                .buttonStyle(.plain)
                .padding(.vertical, isiOS26 ? 0 : 5)
        }
        .onAppear(perform: isLoaded)
        .offset(y: 12)
    }
}

private struct AnimatedPointView: View {
    
    var index: Int
    var point: PaywallPoint
    @State private var animateSymbol = false
    @State private var animateContent = false
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if animateSymbol {
                    Image(systemName: point.symbol)
                        .font(.title2)
                        .symbolVariant(.fill)
                        .foregroundStyle(point.symbolTint)
                        .transition(.blurReplace)
                }
            }
            .frame(width: 35, height: 35)
            
            Text(point.content)
                .font(.callout)
                .fontWeight(.medium)
                .padding(.leading, 10)
                .foregroundStyle(Color.primary)
                .visualEffect({ [animateContent] content, proxy in
                    content
                        .opacity(animateContent ? 1 : 0)
                        .offset(x: animateContent ? 0 : -proxy.size.width)
                })
                .clipped()
            
            Spacer(minLength: 0)
        }
        .task {
            guard !animateSymbol else { return }
            
            try? await Task.sleep(for: .seconds(Double(index) * 0.4))
            withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                animateSymbol = true
            }
            
            try? await Task.sleep(for: .seconds(Double(index) * 0.11))
            withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                animateContent = true
            }
        }
    }
}

struct PaywallPoint: Identifiable {
    var id: String = UUID().uuidString
    var symbol: String
    var symbolTint: Color = .primary
    var content: String
}

#Preview {
    AnimatedPaywallExample()
}
