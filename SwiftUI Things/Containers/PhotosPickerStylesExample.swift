import SwiftUI
import PhotosUI

struct PhotosPickerStylesExample: View {
    
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var style: PhotosPickerStyle = .presentation
    
    var body: some View {
        VStack {
            Spacer()
            
            PhotosPicker("Import photos", selection: $selectedPhotos)
                .photosPickerStyle(style)
                .frame(height: style == .compact ? 500 : .infinity)
            
            Spacer()
            
            Picker("Style", selection: $style) {
                Text("presentation").tag(PhotosPickerStyle.presentation)
                Text("inline").tag(PhotosPickerStyle.inline)
                Text("compact").tag(PhotosPickerStyle.compact)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    PhotosPickerStylesExample()
}
