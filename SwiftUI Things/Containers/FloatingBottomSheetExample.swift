import SwiftUI

struct FloatingBottomSheetExample: View {
    
    private enum SheetType {
        case simple
        case question
        case alert
        case request
    }
    
    @State private var activeSheet: SheetType?
    
    private var showSheet: Binding<Bool> {
        Binding(get: {
            activeSheet != nil
        }, set: {
            activeSheet = $0 ? activeSheet : nil
        })
    }
    
    private func updateSheet(_ value: SheetType) {
        activeSheet = value == activeSheet ? nil : value
    }
    
    @ViewBuilder
    private func simpleSheet() -> some View {
        Text("Hello world!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.background.shadow(.drop(radius: 5)), in: .rect(cornerRadius: 25))
            .padding(.horizontal, 15)
            .padding(.top, 15)
            .presentationDetents([
                .height(100),
                .height(330),
                .fraction(0.999)
            ])
            .presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
    }
    
    @ViewBuilder
    private func questionSheet() -> some View {
        SheetView(
            title: "Replace existing folder?",
            content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            image: .init(
                content: "questionmark.folder.fill",
                tint: .blue,
                foreground: .white
            ),
            button1: .init(
                content: "Replace",
                tint: .blue,
                foreground: .white
            ),
            button2: .init(
                content: "Cancel",
                tint: .primary.opacity(0.08),
                foreground: .primary
            )
        )
        .presentationDetents([
            .height(330),
        ])
        .presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
    }
    
    @ViewBuilder
    private func alertSheet() -> some View {
        SheetView(
            title: "Oooops!",
            content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            image: .init(
                content: "exclamationmark.triangle.fill",
                tint: .red,
                foreground: .white
            ),
            button1: .init(
                content: "Button 1",
                tint: .red,
                foreground: .white
            )
        )
        .presentationDetents([
            .height(330),
        ])
        .presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
    }
    
    @ViewBuilder
    private func requestSheet() -> some View {
        SheetView(
            title: "Lock user?",
            content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            image: .init(
                content: "person.fill.xmark",
                tint: .green,
                foreground: .white
            ),
            button1: .init(
                content: "Lock",
                tint: .green,
                foreground: .white
            ),
            button2: .init(
                content: "Cancel",
                tint: .red,
                foreground: .white
            )
        )
        .presentationDetents([
            .height(330),
        ])
        .presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Button("Simple Sheet") {
                updateSheet(.simple)
            }
            
            Button("Question") {
                updateSheet(.question)
            }
            .background(.blue)
            .foregroundStyle(.white)
            
            Button("Alert") {
                updateSheet(.alert)
            }
            .background(.red)
            .foregroundStyle(.white)
            
            Button("Request") {
                updateSheet(.request)
            }
            .background(.green)
            .foregroundStyle(.white)
            
            Spacer()
        }
        .buttonStyle(.bordered)
        .padding(.top, 36)
        .navigationTitle("Floating Bottom Sheet")
        .floatingBottomSheet(isPresented: showSheet) {
            switch activeSheet {
            case .simple: simpleSheet()
            case .question: questionSheet()
            case .alert: alertSheet()
            case .request: requestSheet()
            case .none: EmptyView()
            }
        }
    }
}

private struct SheetView: View {
    
    struct Config {
        let content: String
        let tint: Color
        let foreground: Color
    }
    
    var title: String
    var content: String
    var image: Config
    var button1: Config
    var button2: Config?
    
    @ViewBuilder
    func buttonView(_ config: Config) -> some View {
        Button {
            // TODO: Implement
        } label: {
            Text(config.content)
                .fontWeight(.bold)
                .foregroundStyle(config.foreground)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(config.tint.gradient, in: .rect(cornerRadius: 10))
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: image.content)
                .font(.title)
                .foregroundStyle(image.foreground)
                .frame(width: 65, height: 65)
                .background(image.tint.gradient, in: .circle)
            
            Text(title)
                .font(.title3.bold())
            
            Text(content)
                .font(.callout)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(.gray)
            
            buttonView(button1)
            
            if let button2 {
                buttonView(button2)
            }
        }
        .padding([.horizontal, .bottom], 15)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
                .padding(.top, 30)
        }
        .shadow(
            color: .black.opacity(0.12),
            radius: 8
        )
        .padding(.horizontal, 15)
    }
}

private extension View {
    
    @ViewBuilder
    func floatingBottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> () = {},
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        
        self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            content()
                .presentationCornerRadius(0)
                .presentationBackground(.clear)
                .presentationDragIndicator(.hidden)
                .background(SheetShadowRemover())
        }
    }
}

private extension UIView {
    
    var viewBeforeWindow: UIView? {
        if let superview, superview is UIWindow {
            return self
        }
        
        return superview?.viewBeforeWindow
    }
}

private struct SheetShadowRemover: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
            if let uiSheetView = view.viewBeforeWindow {
                for view in uiSheetView.subviews {
                    view.layer.shadowColor = UIColor.clear.cgColor
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Empty
    }
}

#Preview {
    NavigationStack {
        FloatingBottomSheetExample()
    }
}
