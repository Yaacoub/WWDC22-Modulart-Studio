import SwiftUI

struct PanelImage: View {
    
    
    
    //MARK: - Properties
    
    @Binding private(set) var backgroundColor: Color
    @Binding private(set) var isOpaqueBackground: Bool
    @Binding private(set) var padding: CGFloat
    @Binding private(set) var width: CGFloat
    @Binding private(set) var height: CGFloat
    
    
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            Text("Export Settings")
                .font(.headline)
                .padding()
            HStack {
                VStack {
                    ControlStepper("Width", systemImage: "arrow.left.and.right.square", value: $width, range: 160...3200, step: 10, unit: "px")
                    ControlStepper("Height", systemImage: "arrow.up.and.down.square", value: $height, range: 160...3200, step: 10, unit: "px")
                    ControlStepper("Padding", systemImage: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left",
                                   value: $padding, range: 0...25, unit: "%")
                    ControlToggle("Opaque Background", systemImage: "checkerboard.rectangle", value: $isOpaqueBackground)
                    if isOpaqueBackground {
                        ControlColorPicker("Background Color", systemImage: "paintpalette", color: $backgroundColor)
                    }
                }
            }
        }
        .background(Color.background)
        .frame(maxWidth: 500)
        .padding()
    }
    
}
