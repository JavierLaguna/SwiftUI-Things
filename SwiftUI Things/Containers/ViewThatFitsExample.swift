
import SwiftUI

struct ViewThatFitsExample: View {
    
    var body: some View {
        VStack {
            VStack {
                UploadProgressView(uploadProgress: 0.75)
                    .frame(maxWidth: 200)
                UploadProgressView(uploadProgress: 0.75)
                    .frame(maxWidth: 100)
                UploadProgressView(uploadProgress: 0.75)
                    .frame(maxWidth: 50)
            }
            
            ViewThatFits {
                HStack(content: OptionsView.init)
                VStack(content: OptionsView.init)
            }
        }
    }
}

private struct UploadProgressView: View {
    
    var uploadProgress: Double
    
    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack {
                Text("\(uploadProgress.formatted(.percent))")
                ProgressView(value: uploadProgress)
                    .frame(width: 100)
            }
            ProgressView(value: uploadProgress)
                .frame(width: 100)
            Text("\(uploadProgress.formatted(.percent))")
        }
    }
}

private struct OptionsView: View {
    
    var body: some View {
        Button("Log in") { }
            .buttonStyle(.borderedProminent)
        
        Button("Create Account") { }
            .buttonStyle(.bordered)
        
        Button("Settings") { }
            .buttonStyle(.bordered)
        
        Spacer().frame(width: 50, height: 50)
        
        Button("Need Help?") { }
    }
}

struct ViewThatFitsExample_Previews: PreviewProvider {
    
    static var previews: some View {
        ViewThatFitsExample()
        
        ViewThatFitsExample()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
