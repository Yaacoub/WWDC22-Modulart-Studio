import SwiftUI

struct ColorPickerRGB: View {
    
    
    
    //MARK: - Properties
    
    @State private var ignoresColorChange = false
    @State private var red = ""
    @State private var green = ""
    @State private var blue = ""
    
    @Binding private(set) var color: Color
    
    
    
    //MARK: - Body
    
    var body: some View {
        HStack {
            Spacer()
            Text("R: ")
            TextField("Red", text: $red)
                .keyboardType(.numberPad)
                .frame(maxWidth: 40)
                .onSubmit {
                    let colorComponent = sanitizedColorComponent(for: red) ?? color.components.red
                    ignoresColorChange = true
                    red = sanitizedDecimal(for: colorComponent)
                    color = Color(red: colorComponent, green: color.components.green, blue: color.components.blue)
                }
            Spacer()
            Text("G: ")
            TextField("Green", text: $green)
                .keyboardType(.numberPad)
                .frame(maxWidth: 40)
                .onSubmit {
                    let colorComponent = sanitizedColorComponent(for: green) ?? color.components.green
                    ignoresColorChange = true
                    green = sanitizedDecimal(for: colorComponent)
                    color = Color(red: color.components.red, green: colorComponent, blue: color.components.blue)
                }
            Spacer()
            Text("B: ")
            TextField("Blue", text: $blue)
                .keyboardType(.numberPad)
                .frame(maxWidth: 40)
                .onSubmit {
                    let colorComponent = sanitizedColorComponent(for: blue) ?? color.components.blue
                    ignoresColorChange = true
                    blue = sanitizedDecimal(for: colorComponent)
                    color = Color(red: color.components.red, green: color.components.green, blue: colorComponent)
                }
            Spacer()
        }
        .onAppear { updateRGB(for: color) }
        .onChange(of: color) { newValue in
            if !ignoresColorChange { updateRGB(for: newValue) }
            ignoresColorChange = false
        }
    }
    
    
    
    //MARK: - Methods
    
    private func sanitizedColorComponent(for decimal: String) -> CGFloat? {
        let decimal = String("\(decimal)".prefix(3)).filter { "0123456789".contains($0) }
        guard let formattedDecimal = Double(decimal) else { return nil }
        let colorComponent = formattedDecimal / 255
        return colorComponent
    }
    
    private func sanitizedDecimal(for colorComponent: CGFloat) -> String {
        let decimal = round(colorComponent * 255)
        let formattedDecimal = String("\(decimal)".prefix(3)).filter { "0123456789".contains($0) }
        return formattedDecimal
    }
    
    private func updateRGB(for color: Color) {
        red = sanitizedDecimal(for: color.components.red)
        green = sanitizedDecimal(for: color.components.green)
        blue = sanitizedDecimal(for: color.components.blue)
    }
    
}
