import SwiftUI

struct ExportView: View {
    
    
    
    //MARK: - Properties
    
    @State private var backgroundColor = Color.black
    @State private var bounce = true
    @State private var exportType = ExportType.image
    @State private var isOpaqueBackground = true
    @State private var padding: CGFloat = 10
    @State private var width: CGFloat = 1000
    @State private var height: CGFloat = 1000
    
    
    
    //MARK: - Enum
    
    private enum ExportType: String, CaseIterable {
        case image = "Image"
        case gif = "GIF"
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                Spacer()
                Picker("Export Type", selection: $exportType) {
                    ForEach(ExportType.allCases, id: \.self) { exportType in
                        Text(exportType.rawValue).tag(exportType)
                    }
                }
                .padding()
                .pickerStyle(.segmented)
                Spacer()
                switch exportType {
                case .image: ExportImage(backgroundColor: $backgroundColor, isOpaqueBackground: $isOpaqueBackground, padding: $padding, width: $width, height: $height)
                case .gif: ExportGIF(backgroundColor: $backgroundColor, bounce: $bounce, padding: $padding, width: $width, height: $height)
                }
                Spacer()
            }
        }
        .navigationTitle("Export")
    }
    
}
