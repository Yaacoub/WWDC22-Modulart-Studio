import SwiftUI

struct ControlGradientPicker: View {
    
    
    
    //MARK: - Properties
    
    private let systemImage: String
    private let title: String
    
    @State private var isPresentingStartColorPicker = false
    @State private var isPresentingEndColorPicker = false
    
    @Binding private(set) var startColor: Color
    @Binding private(set) var endColor: Color
    
    
    
    //MARK: - Init
    
    init(_ title: String, systemImage: String, startColor: Binding<Color>, endColor: Binding<Color>) {
        self.systemImage = systemImage
        self.title = title
        self._startColor = startColor
        self._endColor = endColor
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        HStack {
            Label(title, systemImage: systemImage)
            Spacer()
            Button {
                isPresentingStartColorPicker = true
            } label: {
                Circle()
                    .foregroundColor(startColor)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Circle()
                            .strokeBorder(Color.text, lineWidth: 1)
                    }
            }
            .popover(isPresented: $isPresentingStartColorPicker) {
                ColorPickerSheet(selection: $startColor)
            }
            Button {
                (startColor, endColor) = (endColor, startColor)
            } label: {
                Image(systemName: "arrow.left.arrow.right")
            }
            .padding(.horizontal)
            Button {
                isPresentingEndColorPicker = true
            } label: {
                Circle()
                    .foregroundColor(endColor)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Circle()
                            .strokeBorder(Color.text, lineWidth: 1)
                    }
            }
            .popover(isPresented: $isPresentingEndColorPicker) {
                ColorPickerSheet(selection: $endColor)
            }
        }
        .padding(.trailing)
    }
    
}
