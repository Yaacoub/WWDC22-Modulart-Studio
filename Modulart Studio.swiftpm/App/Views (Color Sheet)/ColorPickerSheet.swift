import SwiftUI

struct ColorPickerSheet: View {
    
    
    
    //MARK: - Properties
    
    @Binding private var selection: Color
    private var colors = [
        Color(red: 0.5, green: 0.5, blue: 0.5),
        Color(red: 1, green: 0, blue: 0),
        Color(red: 1, green: 0.5, blue: 0),
        Color(red: 1, green: 1, blue: 0),
        Color(red: 0, green: 1, blue: 0),
        Color(red: 0, green: 0, blue: 1),
        Color(red: 0.5, green: 0, blue: 1),
        Color(red: 1, green: 0, blue: 1)
    ]
    private var items = Array(repeating: GridItem(.fixed(30), spacing: 0), count: 11)
    
    
    
    //MARK: - Init
    
    init(selection: Binding<Color>) {
        self._selection = selection
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color.backgroundSecondary
                .ignoresSafeArea()
            VStack {
                LazyVGrid(columns: items, spacing: 0) {
                    ForEach(0..<(colors.count * items.count), id: \.self) { index in
                        let colorVariation = colorVariation(for: colors[index / items.count], index: index % items.count, variations: items.count)
                        Button {
                            selection = colorVariation
                        } label: {
                            Rectangle()
                                .foregroundColor(colorVariation)
                                .frame(width: 30, height: 30)
                                .overlay {
                                    Rectangle()
                                        .strokeBorder(Color.backgroundSecondary, lineWidth: selection == colorVariation ? 4 : 0)
                                }
                        }
                    }
                }
                .cornerRadius(10)
                ColorPickerRGB(color: $selection)
            }
            .padding()
        }
    }
    
    
    
    //MARK: - Methods
    
    private func colorVariation(for color: Color, index: Int, variations: Int) -> Color {
        let isGray = color == Color(red: 0.5, green: 0.5, blue: 0.5)
        let totalForPercentage = Double(variations) / 2
        if index < variations / 2 {
            let percentage = (Double(index) + (isGray ? 0 : 1)) / (floor(totalForPercentage) + (isGray ? 0 : 1))
            return color.shaded(by: percentage)
        } else if index > variations / 2 {
            let percentage = (Double(index) - floor(totalForPercentage)) / (floor(totalForPercentage) + (isGray ? 0 : 1))
            return color.tinted(by: percentage)
        } else {
            return color
        }
    }
    
}
