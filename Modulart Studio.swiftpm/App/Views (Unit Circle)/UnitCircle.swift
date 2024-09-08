import SwiftUI

struct UnitCircle: View {
    
    
    
    //MARK: - Properties
    
    private let animationDuration: Double
    private let animationPercentage: Double
    
    @EnvironmentObject private var document: Document
    
    
    
    //MARK: - Init
    
    init(animationDuration: Double = 0, animationPercentage: Double = 1) {
        self.animationDuration = animationDuration
        self.animationPercentage = animationPercentage
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        let angularGradient = AngularGradient(colors: [document.properties.colorStart, document.properties.colorEnd],
                                              center: .center, angle: .degrees(document.properties.angleStart - 90))
        Circle()
            .strokeBorder(angularGradient, lineWidth: document.properties.lineWidth)
            .overlay {
                ZStack {
                    let colors = blendedColors(document.properties.colorStart, document.properties.colorEnd, count: document.properties.dashes)
                    UnitCircleDashes(colors: colors)
                    UnitCircleLines(animationDuration: animationDuration, animationPercentage: animationPercentage, colors: colors)
                        .mask(Circle())
                }
            }
    }
    
    
    
    //MARK: - Methods
    
    private func blendedColors(_ color1: Color, _ color2: Color, count: Int) -> [Color] {
        var result: [Color] = []
        for i in 0..<count {
            let percentage = 1 - Double(i) / Double(count)
            let blendedRed = color1.components.red * percentage + color2.components.red * (1 - percentage)
            let blendedGreen = color1.components.green * percentage + color2.components.green * (1 - percentage)
            let blendedBlue = color1.components.blue * percentage + color2.components.blue * (1 - percentage)
            result.append(Color(red: blendedRed, green: blendedGreen, blue: blendedBlue))
        }
        return result
    }
    
}
