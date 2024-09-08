import SwiftUI

struct ExportImage: View {
    
    
    
    //MARK: - Properties
    
    @EnvironmentObject private var document: Document
    @State private var isCopying = false
    private var circle: some View {
        UnitCircle()
            .environmentObject(document)
            .foregroundColor(foregroundColor(for: backgroundColor))
            .padding(document.properties.showNumbers ? 40 : 0)
    }
    
    @Binding private(set) var backgroundColor: Color
    @Binding private(set) var isOpaqueBackground: Bool
    @Binding private(set) var padding: CGFloat
    @Binding private(set) var width: CGFloat
    @Binding private(set) var height: CGFloat
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                Spacer()
                preview(maxSize: 400)
                    .frame(maxWidth: 400, maxHeight: 400)
                    .shadow(radius: 10)
                    .padding([.horizontal, .top])
                Text("This preview is an approximation of the final PNG image.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .opacity(0.75)
                Spacer()
                PanelImage(backgroundColor: $backgroundColor, isOpaqueBackground: $isOpaqueBackground, padding: $padding, width: $width, height: $height)
                    .padding()
                ZStack {
                    Button("Copy to Clipboard") { isCopying = true }
                        .buttonBorderShape(.capsule)
                        .buttonStyle(.bordered)
                        .disabled(isCopying)
                    ProgressView()
                        .opacity(isCopying ? 1 : 0)
                }
                .controlSize(.large)
                Spacer()
            }
        }
        .navigationTitle("Export Image")
        .onChange(of: isCopying) { newValue in
            guard newValue else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                copyFile(for: preview().renderedImage(for: CGSize(width: width, height: height)))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isCopying = false
            }
        }
    }
    
    
    
    //MARK: - Methods
    
    private func copyFile(for image: UIImage) {
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let imageURL = tempURL.appendingPathComponent("Untitled").appendingPathExtension("png")
        try? image.pngData()?.write(to: imageURL)
        UIPasteboard.general.items = [["com.apple.uikit.image": image, "public.png": image, "public.jpeg": image, "public.file-url": imageURL]]
    }
    
    private func preview(maxSize: CGFloat = .greatestFiniteMagnitude) -> some View {
        let size = min(width, height, maxSize)
        let padding = min(height / width * size, width / height * size) * padding / 100
        return ZStack {
            if isOpaqueBackground { backgroundColor }
            Image(uiImage: circle.renderedImage(for: CGSize(width: size, height: size)))
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding(padding)
        }
        .aspectRatio(width / height, contentMode: .fit)
    }
    
    private func foregroundColor(for backgroundColor: Color) -> Color {
        let contrastRatio1L1 = max(Color.background.luminance, backgroundColor.luminance)
        let contrastRatio1L2 = min(Color.background.luminance, backgroundColor.luminance)
        let contrastRatio1 = (contrastRatio1L1 + 0.05) / (contrastRatio1L2 + 0.05)
        let contrastRatio2L1 = max(Color.text.luminance, backgroundColor.luminance)
        let contrastRatio2L2 = min(Color.text.luminance, backgroundColor.luminance)
        let contrastRatio2 = (contrastRatio2L1 + 0.05) / (contrastRatio2L2 + 0.05)
        return contrastRatio1 > contrastRatio2 ? .background : .text
    }
    
}
