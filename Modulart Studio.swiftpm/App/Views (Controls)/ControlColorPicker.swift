import SwiftUI

struct ControlColorPicker: View {
    
    
    
    //MARK: - Properties
    
    private let systemImage: String
    private let title: String
    
    @State private var isPresentingColorPicker = false
    
    @Binding private(set) var color: Color
    
    
    
    //MARK: - Init
    
    init(_ title: String, systemImage: String, color: Binding<Color>) {
        self.systemImage = systemImage
        self.title = title
        self._color = color
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        HStack {
            Label(title, systemImage: systemImage)
            Spacer()
            Button {
                isPresentingColorPicker = true
            } label: {
                Circle()
                    .foregroundColor(color)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Circle()
                            .strokeBorder(Color.text, lineWidth: 1)
                    }
            }
            .popover(isPresented: $isPresentingColorPicker) {
                ColorPickerSheet(selection: $color)
            }
        }
        .padding(.trailing)
    }
    
}
