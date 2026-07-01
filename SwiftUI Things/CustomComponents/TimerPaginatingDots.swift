import SwiftUI

struct TimerPaginatingDots: View {
    
    @State private var isPaused = false
    @State private var activeIndex = 0
    
    var body: some View {
        VStack {
            let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .cyan]
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(colors.indices, id: \.self) { index in
                        let color = colors[index]
                        
                        RoundedRectangle(cornerRadius: 30)
                            .fill(color.gradient)
                            .containerRelativeFrame(.horizontal)
                        
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, 20)
            .scrollIndicators(.hidden)
            .scrollPosition(id: .init(get: {
                return activeIndex
            }, set: { newIndex in
                guard let newIndex else { return }
                activeIndex = newIndex
            }), anchor: .center)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
            .frame(height: 220)
            .onScrollPhaseChange { oldPhase, newPhase in
                isPaused = newPhase != .idle && newPhase != .animating
            }
            .animation(.easeInOut(duration: 0.25), value: activeIndex)
            
            TimedPagingIndicator(
                count: 5,
                duration: 2,
                isPaused: isPaused,
                selection: $activeIndex
            )
        }
    }
}

struct TimedPagingIndicator: View {
    
    var count: Int
    var duration: CGFloat
    var isPaused: Bool
    var activeTint: Color = .primary
    var inActiveTint: Color = .gray
    @Binding var selection: Int
    
    @State private var startDate: Date = .now
    @State private var isTimelinePaused: Bool?
    
    private var animation: Animation {
        .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
    }
    
    private func updateIndex() {
        if selection == (count - 1) {
            selection = 0
        } else {
            let nextIndex = min(selection + 1, count - 1)
            selection = nextIndex
        }
    }
    
    var body: some View {
        TimelineView(.animation(paused: isTimelinePaused ?? isPaused)) { ctx in
            let diff = startDate.distance(to: ctx.date)
            let progress = max(min(diff / duration, 1), 0)
            let progressIndex = Int(progress)
            
            HStack(spacing: 5) {
                ForEach(0..<count, id: \.self) { index in
                    let isActive = selection == index
                    
                    Rectangle()
                        .fill(inActiveTint)
                        .overlay(alignment: .leading) {
                            if isActive {
                                Rectangle()
                                    .fill(activeTint)
                                    .scaleEffect(
                                        x: isPaused ? 1 : progress,
                                        anchor: .leading
                                    )
                            }
                        }
                        .frame(
                            width: isActive ? (isPaused ? 5 : 20) : 5,
                            height: 5
                        )
                        .clipShape(.capsule)
                }
            }
            .frame(maxHeight: .infinity)
            .onChange(of: progressIndex) { oldValue, newValue in
                if newValue == 1 {
                    updateIndex()
                }
            }
        }
        .frame(height: 10)
        .onChange(of: isPaused) { oldValue, newValue in
            startDate = .now
            isTimelinePaused = newValue
        }
        .onChange(of: selection) { oldValue, newValue in
            startDate = .now
        }
        .onAppear {
            isTimelinePaused = isPaused
        }
        .animation(animation, value: selection)
        .animation(animation, value: isPaused)
    }
}

#Preview {
    TimerPaginatingDots()
}
