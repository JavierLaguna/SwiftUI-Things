
import SwiftUI

struct RestartOnboardingView: View {
    
    @AppStorage(Constants.AppStorage.restartOnboarding) var isOnboardingViewActive: Bool = true
    
    @State private var didAppear: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
          It's not how much we give but
          how much love we put into giving.
          """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }
                .opacity(didAppear ? 1 : 0)
                .offset(y: didAppear ? 0 : -40)
                .animation(.easeOut(duration: 1), value: didAppear)
                
                // MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(didAppear ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: didAppear)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(didAppear ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: didAppear)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                
                // MARK: - FOOTER
                
                SlideTo(title: "Get Started") {
                    playSound(sound: "chimeup", type: "mp3")
                    isOnboardingViewActive = false
                }
                .opacity(didAppear ? 1 : 0)
                .offset(y: didAppear ? 0 : 40)
                .animation(.easeOut(duration: 1), value: didAppear)
            }
        }
        .onAppear(perform: {
            didAppear = true
        })
        .preferredColorScheme(.dark)
    }
}

struct RestartOnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        RestartOnboardingView()
    }
}


