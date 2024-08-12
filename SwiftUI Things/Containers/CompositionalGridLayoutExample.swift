
import SwiftUI

struct CompositionalGridLayoutExample: View {
    
    @State private var count = 3
    
    @ViewBuilder
    var pickerView: some View {
        Picker("", selection: $count) {
            ForEach(1...4, id: \.self) {
                Text("Count = \($0)")
                    .tag($0)
            }
        }
        .pickerStyle(.segmented)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 6) {
                pickerView
                    .padding(.bottom, 10)
                
                CompositionalGridLayout(count: count) {
                    ForEach(1...50, id: \.self) { index in
                        Rectangle()
                            .fill(.black.gradient)
                            .overlay {
                                Text("\(index)")
                                    .font(.largeTitle.bold())
                                    .foregroundStyle(.white)
                            }
                    }
                }
                .animation(.bouncy, value: count)
            }
            .padding(15)
        }
        .navigationTitle("Compositional Grid")
    }
}

#Preview {
    NavigationStack {
        CompositionalGridLayoutExample()
    }
}
