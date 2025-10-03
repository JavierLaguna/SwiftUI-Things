// Credits: Kavsoft
// https://www.youtube.com/watch?v=FVssSeric50

import SwiftUI
import PDFKit

struct SwiftUIViewToPDF: View {
    
    @State private var pdfURL: URL?
    @State private var showFileMover = false
    
    private var fileURL: URL? {
        try? PDFMaker.create(pageCount: 3, pageContent: { pageIndex in
            Text("Hello World \(pageIndex)")
                .font(.largeTitle.bold())
        })
    }
    
    private var fileURL2: URL? {
        let pageCount = Int((PDFMaker.PageSize.a4().size.height - 120) / 80)
        let chunkTransactions = transactions.chunked(into: pageCount)
        
        return try? PDFMaker.create(pageCount: chunkTransactions.count, pageContent: { pageIndex in
            ExportablePageView(pageIndex: pageIndex, transactions: chunkTransactions[pageIndex])
        })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ShareLink("Share PDF", item: fileURL2!)
                
                Button("Export PDF") {
                    if let pdfURL = fileURL2 {
                        self.pdfURL = pdfURL
                        showFileMover.toggle()
                    }
                }
            }
            .navigationTitle("PDF Helper")
        }
        .fileMover(isPresented: $showFileMover, file: pdfURL) { result in
            print(result)
        }
    }
}

private struct PDFMaker {
    
    static func create<PageContent: View>(
        _ pageSize: PageSize = .a4(),
        pageCount: Int,
        format: UIGraphicsPDFRendererFormat = .default(),
        fileURL: URL = FileManager.default.temporaryDirectory.appending(path: "\(UUID().uuidString).pdf"),
        @ViewBuilder pageContent: (_ pageIndex: Int) -> PageContent
    ) throws -> URL? {
        let size = pageSize.size
        let rect = CGRect(origin: .zero, size: size)
        
        let renderer = UIGraphicsPDFRenderer(bounds: rect, format: format)
        try renderer.writePDF(to: fileURL) { context in
            for index in 0..<pageCount {
                context.beginPage()
                
                let pageContent = pageContent(index)
                let swiftUIRenderer = ImageRenderer(content: pageContent.frame(width: size.width, height: size.height))
                swiftUIRenderer.proposedSize = .init(size)
                
                context.cgContext.translateBy(x: 0, y: size.height)
                context.cgContext.scaleBy(x: 1, y: -1)
                
                swiftUIRenderer.render { _, swiftUIContext in
                    swiftUIContext(context.cgContext)
                }
            }
        }
        return fileURL
    }
    
    struct PageSize {
        
        let size: CGSize
        
        init(width: CGFloat, height: CGFloat) {
            self.size = CGSize(width: width, height: height)
        }
        
        static func a4() -> Self {
            .init(width: 595.2, height: 841.8)
        }
        
        static func usLetter() -> Self {
            .init(width: 612, height: 792)
        }
    }
}

private struct Transaction: Identifiable {
    var id: String = UUID().uuidString
    var name: String = "iPhone Air"
    var account: String = "Main Account"
    var date: String = "24 Sep 2025"
    var category: String = "Apple"
    var amount: String = "$999"
}

private let transactions: [Transaction] = (1...50).compactMap({ _ in .init() })

private struct ExportablePageView: View {
    
    var pageIndex: Int
    var transactions: [Transaction]
    
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack(spacing: 10) {
            Image(systemName: "applelogo")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
                .background(.black, in: .rect(cornerRadius: 15))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("App - App Description")
                    .font(.callout)
                
                Text("Justine Ezarik")
                    .font(.caption)
            }
            .lineLimit(1)
            
            Spacer(minLength: 0)
        }
        .frame(height: 50)
        .frame(height: 80, alignment: .top)
    }
    
    @ViewBuilder
    private func TransactionView(_ transaction: Transaction) -> some View {
        VStack(spacing: 4) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(transaction.name)
                        .font(.callout)
                        .lineLimit(1)
                    
                    Text(transaction.amount)
                        .font(.caption)
                        .fontWeight(.medium)
                        .underline()
                        .lineLimit(1)
                    
                    Text("Category: \(transaction.category)")
                        .font(.caption2)
                        .lineLimit(1)
                        .foregroundStyle(.gray)
                }
                
                Spacer(minLength: 6)
                
                VStack(alignment: .center, spacing: 6) {
                    Text(transaction.amount)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.green)
                    
                    Text(transaction.date)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
            }
            
            Divider()
        }
        .frame(height: 80, alignment: .top)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            ForEach(transactions) { transaction in
                TransactionView(transaction)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .overlay(alignment: .bottom) {
            Text("\(pageIndex + 1)")
                .font(.caption2)
                .fontWeight(.semibold)
                .offset(y: -8)
        }
        .background(.white)
        .environment(\.colorScheme, .light)
    }
}

private extension Array {
    
    func chunked(into size: Int) -> [[Element]]{
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    SwiftUIViewToPDF()
}
