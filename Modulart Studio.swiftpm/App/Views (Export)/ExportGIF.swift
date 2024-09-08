import SwiftUI
import UniformTypeIdentifiers

struct ExportGIF: View {
    
    
    
    //MARK: - Properties
    
    @EnvironmentObject private var document: Document
    @State private var isCopying = false
    
    @Binding private(set) var backgroundColor: Color
    @Binding private(set) var bounce: Bool
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
                preview(maxSize: 400, percentage: 1)
                    .frame(maxWidth: 400, maxHeight: 400)
                    .shadow(radius: 10)
                    .padding([.horizontal, .top])
                Text("This still preview is an approximation of the final GIF animation.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .opacity(0.75)
                Spacer()
                PanelGIF(backgroundColor: $backgroundColor, bounce: $bounce, padding: $padding, width: $width, height: $height)
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
        .navigationTitle("Export GIF")
        .onAppear {
            height = min(height, 1000)
            width = min(width, 1000)
        }
        .onChange(of: isCopying) { newValue in
            guard newValue else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                copyGeneratedGif(for: generatedImages())
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isCopying = false
            }
        }
    }
    
    
    
    //MARK: - Methods
    
    private func circle(percentage: Double) -> some View {
        UnitCircle(animationPercentage: percentage)
            .environmentObject(document)
            .foregroundColor(foregroundColor(for: backgroundColor))
            .padding(document.properties.showNumbers ? 40 : 0)
    }
    
    private func copyGeneratedGif(for images: [UIImage]) {
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let gifURL = tempURL.appendingPathComponent("Untitled").appendingPathExtension("gif")
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]
        let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: 0.125]]
        let cfurl = gifURL as CFURL
        if let destination = CGImageDestinationCreateWithURL(cfurl, UTType.gif.identifier as CFString, images.count, nil) {
            CGImageDestinationSetProperties(destination, fileProperties as CFDictionary?)
            for image in images {
                CGImageDestinationAddImage(destination, image.cgImage!, gifProperties as CFDictionary?)
            }
            CGImageDestinationFinalize(destination)
        }
        UIPasteboard.general.items = [["public.file-url": gifURL]]
    }
    
    private func generatedImages() -> [UIImage] {
        let frameCount = 10
        var images: [UIImage] = []
        for i in 0..<frameCount {
            let percentage = Double(i) / Double(frameCount - 1)
            images.append(preview(percentage: percentage).renderedImage(for: CGSize(width: width, height: height)))
        }
        return bounce ? images + images.reversed() : images
    }
    
    private func preview(maxSize: CGFloat = .greatestFiniteMagnitude, percentage: Double) -> some View {
        let size = min(width, height, maxSize)
        let padding = min(height / width * size, width / height * size) * padding / 100
        return ZStack {
            backgroundColor
            Image(uiImage: circle(percentage: percentage).renderedImage(for: CGSize(width: size, height: size)))
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding(padding)
        }
        .aspectRatio(width / height, contentMode: .fit)
    }
    
    private func foregroundColor(for backgroundColor: Color) -> Color {
        let contrastRatio1 = (max(Color.background.luminance, backgroundColor.luminance) + 0.05) / (min(Color.background.luminance, backgroundColor.luminance) + 0.05)
        let contrastRatio2 = (max(Color.text.luminance, backgroundColor.luminance) + 0.05) / (min(Color.text.luminance, backgroundColor.luminance) + 0.05)
        return contrastRatio1 > contrastRatio2 ? .background : .text
    }
    
}
