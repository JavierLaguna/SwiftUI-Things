import SwiftUI

struct MixColorsExample: View {
    
    @State private var color1 = Color.yellow
    @State private var color2 = Color.green
    @State private var by: Double = 0.5
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ColorPicker("Color 1", selection: $color1)
                }
                .frame(width: 150, height: 150)
                .background(color1)
                
                Image(systemName: "plus.app")
                    .font(.largeTitle)
                
                VStack {
                    ColorPicker("Color 2", selection: $color2)
                }
                .frame(width: 150, height: 150)
                .background(color2)
            }
            
            Slider(value: $by, in: 0...1)
                .padding()
            
            Image(systemName: "arrowshape.down.circle")
                .font(.largeTitle)
                .padding()
            
            Color(color1)
                .mix(with: color2, by: by)
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    MixColorsExample()
}
