import SwiftUI

struct PanelLayout: View {
    
    
    
    //MARK: - Properties
    
    @EnvironmentObject private var document: Document
    
    
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            Text("Layout")
                .font(.headline)
                .padding()
            HStack {
                VStack {
                    ControlStepper("Angle Start", systemImage: "rotate.right", value: $document.properties.angleStart, range: 0...360, unit: "º")
                    ControlStepper("Dash Size", systemImage: "circle.hexagonpath", value: $document.properties.dashSize, range: 0...20, unit: "px")
                    ControlStepper("Line Width", systemImage: "lineweight", value: $document.properties.lineWidth, range: 1...10, unit: "px")
                    ControlToggle("Show Numbers", systemImage: "0.circle", value: $document.properties.showNumbers)
                    ControlGradientPicker("Line Colors", systemImage: "paintpalette", startColor: $document.properties.colorStart,
                                          endColor: $document.properties.colorEnd)
                }
            }
        }
        .background(Color.background)
        .frame(maxWidth: 500)
        .padding()
    }
    
}
