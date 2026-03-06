import SwiftUI

let monthHeight: CGFloat = 400

struct CalendarView: View {
    
    @State private var months: [Month] = []
    @State private var scrollPosition: ScrollPosition = .init()
    
    // Infinite Scroll Properties
    @State private var isLoadingTop = false
    @State private var isLoadingBottom = false
    @State private var isResetting = false
    
    private func loadInitialData() {
        months = Date.now.initialLoadMonth
        /// Centering Scroll Position
        let centerOffset = (CGFloat(months.count / 2) * monthHeight) - (monthHeight / 2)
        scrollPosition.scrollTo(y: centerOffset)
    }
    
    private func loadFutureMonths(info: ScrollInfo) {
        isLoadingBottom = true
        let futureMonths = months.createMonths(10, isPast: false)
        months.append(contentsOf: futureMonths)
        
        if months.count > 30 {
            adjustScrollContentOffset(removesTop: true, info: info)
        }
        
        // Resetting Status in DispatchQueue (This avoids infinite creation)
        DispatchQueue.main.async {
            isLoadingBottom = false
        }
    }
    
    private func loadPastMonths(info: ScrollInfo) {
        isLoadingTop = true
        let pastMonths = months.createMonths(10, isPast: true)
        months.insert(contentsOf: pastMonths, at: 0)
        
        adjustScrollContentOffset(removesTop: false, info: info)
        
        // Resetting Status in DispatchQueue (This avoids infinite creation)
        DispatchQueue.main.async {
            isLoadingTop = false
        }
    }
    
    private func adjustScrollContentOffset(removesTop: Bool, info: ScrollInfo) {
        let previousContentHeight = info.contentHeight
        let previousOffset = info.offsetY
        // We´re adding or removing 10 items
        let adjustmentHeight: CGFloat = monthHeight * 10
        
        if removesTop {
            months.removeFirst(10)
        } else {
            if months.count > 30 {
                months.removeLast(10)
            }
        }
        
        let newContentHeight = previousContentHeight + (removesTop ? -adjustmentHeight : adjustmentHeight)
        let newContentOffset = previousOffset + (newContentHeight - previousContentHeight)
        
        var transaction = Transaction()
        transaction.scrollPositionUpdatePreservesVelocity = true
        withTransaction(transaction) {
            scrollPosition.scrollTo(y: newContentOffset)
        }
    }
    
    @ViewBuilder
    private func SymbolView() -> some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .overlay(alignment: .bottom) {
            Divider()
        }
        .background(.ultraThinMaterial)
    }
    
    @ViewBuilder
    private func BottomBar() -> some View {
        HStack {
            Button {
                isResetting = true
                loadInitialData()
                DispatchQueue.main.async {
                    isResetting = false
                }
                
            } label: {
                Text("Today")
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.background, in: .capsule)
            }
            
            Spacer(minLength: 0)
            
            Text("Array Count: \(months.count)")
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.background, in: .capsule)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask {
                    LinearGradient(
                        colors: [
                            .clear,
                            .white.opacity(0.7),
                            .white,
                            .white
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .padding(.top, -30)
                .ignoresSafeArea()
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(months) { month in
                    MonthView(month: month)
                        .frame(height: monthHeight)
                }
            }
        }
        .scrollPosition($scrollPosition)
        .defaultScrollAnchor(.center)
        .onScrollGeometryChange(for: ScrollInfo.self, of: {
            let offsetY = $0.contentOffset.y + $0.contentInsets.top
            let contentHeight = $0.contentSize.height
            let containerHeight = $0.containerSize.height
            
            return .init(
                offsetY: offsetY,
                contentHeight: contentHeight,
                containerHeight: containerHeight
            )
            
        }, action: { oldValue, newValue in
            guard months.count >= 10 && !isResetting else { return }
            
            let threshold: CGFloat = 100
            let offsetY = newValue.offsetY
            let contentHeight = newValue.contentHeight
            let frameHeight = newValue.containerHeight
            
            if offsetY > (contentHeight - frameHeight - threshold) && !isLoadingBottom {
                // Loading Future Months
                loadFutureMonths(info: newValue)
            }
            
            if offsetY < threshold && !isLoadingTop {
                // Loading Past Months
                loadPastMonths(info: newValue)
            }
        })
        .background(ScrollToTopDisable())
        .compositingGroup()
        .safeAreaInset(edge: .top, spacing: 0) {
            SymbolView()
        }
        .overlay(alignment: .bottom) {
            BottomBar()
        }
        .onAppear {
            guard months.isEmpty else { return }
            
            loadInitialData()
        }
    }
}

private struct MonthView: View {
    
    let month: Month
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(month.name)
                .font(.title2)
                .fontWeight(.bold)
                .frame(height: 50, alignment: .bottom)
            
            /// Weeks View
            VStack(spacing: 0) {
                ForEach(month.weeks) { week in
                    HStack(spacing: 0) {
                        /// Days View
                        ForEach(week.days) { day in
                            DayView(day: day)
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .overlay(alignment: .bottom) {
                        if !week.isLast {
                            Divider()
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 15)
    }
}

private struct DayView: View {
    
    let day: Day
    
    var body: some View {
        if let dayValue = day.value, let date = day.date, !day.isPlaceholder {
            let isToday = Calendar.current.isDateInToday(date)
            
            Text("\(dayValue)")
                .font(.callout)
                .fontWeight(isToday ? .semibold : .regular)
                .foregroundStyle(isToday ? .white : .primary)
                .frame(width: 30, height: 30)
                .background {
                    if isToday {
                        Circle()
                            .fill(.blue.gradient)
                    }
                }
                .frame(maxWidth: .infinity)
            
        } else {
            Color.clear
        }
    }
}

#Preview {
    CalendarView()
}
